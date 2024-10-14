from django.http import HttpResponse
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import IsAuthenticated
from rest_framework import status
from rest_framework import viewsets
from .management.commands.get_status import Command
from django.shortcuts import get_object_or_404
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.hashers import make_password, check_password
from django.shortcuts import render
from django.db.models.signals import post_save, post_delete
from django.dispatch import receiver
from .models import Dosen, Mahasiswa, Admins, Pengguna
from .permissions import IsMahasiswa, IsDosen, IsAdmin
from .serializers import DosenSerializer, MahasiswaSerializer, AdminsSerializer, PenggunaSerializer

class DosenViewSet(viewsets.ModelViewSet):
    queryset = Dosen.objects.all()
    serializer_class = DosenSerializer
    lookup_field = 'id_dosen'

    def list(self, request, *args, **kwargs):
        queryset = self.filter_queryset(self.get_queryset())
        serializer = self.get_serializer(queryset, many=True)

        # Jalankan fungsi untuk menghitung status
        get_status = Command()
        get_status.handle()

        return Response({'data': serializer.data}, status=status.HTTP_200_OK)
    
    def destroy(self, request, *args, **kwargs):
        dosen = get_object_or_404(Dosen, id_dosen=kwargs['id_dosen'])
        dosen.delete()
        return Response({'message': 'Dosen berhasil dihapus'}, status=status.HTTP_200_OK)
    

class MahasiswaViewSet(viewsets.ModelViewSet):
    queryset = Mahasiswa.objects.all()
    serializer_class = MahasiswaSerializer

    def list(self, request, *args, **kwargs):
        queryset = self.filter_queryset(self.get_queryset())
        serializer = self.get_serializer(queryset, many=True)

        # Jalankan fungsi untuk menghitung status
        get_status = Command()
        get_status.handle()

        # Mengembalikan response dengan data mahasiswa dan status 200 OK
        return Response({'data': serializer.data}, status=status.HTTP_200_OK)
    
    def destroy(self, request, *args, **kwargs):
        dosen = get_object_or_404(Mahasiswa, id_mahasiswa=kwargs['id_mahasiswa'])
        dosen.delete()
        return Response({'message': 'Mahasiswa berhasil dihapus'}, status=status.HTTP_200_OK)

class ListMahasiswaViewSet(viewsets.ViewSet):
    def list(self, request):
        # Mengambil semua mahasiswa yang id_dosennya bernilai null atau 0
        queryset = Mahasiswa.objects.filter(id_dosen__isnull=True) | Mahasiswa.objects.filter(id_dosen=0)
        
        # Serialize data mahasiswa
        serializer = MahasiswaSerializer(queryset, many=True)
        
        # Mengembalikan response dengan data mahasiswa
        return Response({'data': serializer.data})

class AdminsViewSet(viewsets.ModelViewSet):
    queryset = Admins.objects.all()
    serializer_class = AdminsSerializer

    def list(self, request, *args, **kwargs):
        queryset = self.filter_queryset(self.get_queryset())
        serializer = self.get_serializer(queryset, many=True)
        return Response({'data': serializer.data}, status=status.HTTP_200_OK)

class PenggunaViewSet(viewsets.ModelViewSet):
    queryset = Pengguna.objects.all()
    serializer_class = PenggunaSerializer

    def list(self, request, *args, **kwargs):
        queryset = self.filter_queryset(self.get_queryset())
        serializer = self.get_serializer(queryset, many=True)
        return Response({'data': serializer.data}, status=status.HTTP_200_OK)

    def update(self, request, *args, **kwargs):
        instance = self.get_object()
        data = request.data

        # Jika ada password dalam data yang dikirim, hash password tersebut
        if 'password' in data:
            data['password'] = make_password(data['password'])

        serializer = self.get_serializer(instance, data=data, partial=True)
        serializer.is_valid(raise_exception=True)
        self.perform_update(serializer)

        return Response({'data': serializer.data}, status=status.HTTP_200_OK)
    
class PerwalianListView(APIView):
    def get(self, request, id_dosen):
        mahasiswa_perwalian = Mahasiswa.objects.filter(id_dosen=id_dosen)
        serializer = MahasiswaSerializer(mahasiswa_perwalian, many=True)
        # Jalankan fungsi untuk menghitung status
        get_status = Command()
        get_status.handle()
        return Response({'data': serializer.data}, status=status.HTTP_200_OK)

@receiver(post_save, sender=Dosen)
def create_or_update_pengguna_dosen(sender, instance, created, **kwargs):
    if created:
        pengguna = Pengguna.objects.create(id_pengguna=instance.id_pengguna, username=instance.nip, role='dosen')
        instance.id_pengguna = pengguna
        instance.save()
    else:
        try:
            pengguna = Pengguna.objects.get(id_pengguna=instance.id_pengguna.id_pengguna)
            pengguna.username = instance.nip
            pengguna.role = 'dosen'
            pengguna.save()
        except Pengguna.DoesNotExist:
            pengguna = Pengguna.objects.create(id_pengguna=instance.id_pengguna.id_pengguna, username=instance.nip, role='dosen')
            instance.id_pengguna = pengguna
            instance.save()


@receiver(post_delete, sender=Dosen)
def delete_pengguna_dosen(sender, instance, **kwargs):
    # Ambil objek Pengguna yang terkait dengan Dosen yang dihapus
    id_pengguna = instance.id_pengguna_id  # Mengambil nilai id_pengguna, bukan objek Pengguna
    try:
        pengguna = Pengguna.objects.get(id_pengguna=id_pengguna)
        pengguna.delete()
    except Pengguna.DoesNotExist:
        pass 

@receiver(post_save, sender=Mahasiswa)
def create_or_update_pengguna_mahasiswa(sender, instance, created, **kwargs):
    if created:
        # Jika objek Dosen baru dibuat, buat objek Pengguna dengan nilai id_pengguna yang sesuai
        Pengguna.objects.create(id_pengguna=instance.id_pengguna, username=instance.nim, role='mahasiswa')
    else:
        # Jika objek Dosen diperbarui
        try:
            # Ambil objek Pengguna yang terkait dengan objek Dosen
            pengguna = Pengguna.objects.get(id_pengguna=instance.id_pengguna.id_pengguna)
            # Perbarui username Pengguna sesuai dengan nilai nim
            pengguna.username = instance.nim
            pengguna.role = 'mahasiswa'
            pengguna.save()
        except Pengguna.DoesNotExist:
            # Jika objek Pengguna tidak ditemukan, buat objek Pengguna baru dengan nilai id_pengguna dari objek Dosen
            Pengguna.objects.create(id_pengguna=instance.id_pengguna.id_pengguna, username=instance.nim, role='mahasiswa')

@receiver(post_delete, sender=Mahasiswa)
def delete_pengguna_mahasiswa(sender, instance, **kwargs):
    # Ambil objek Pengguna yang terkait dengan Dosen yang dihapus
    id_pengguna = instance.id_pengguna_id  # Mengambil nilai id_pengguna, bukan objek Pengguna
    try:
        pengguna = Pengguna.objects.get(id_pengguna=id_pengguna)
        pengguna.delete()
    except Pengguna.DoesNotExist:
        pass 

@receiver(post_save, sender=Pengguna)
def update_id_pengguna(sender, instance, created, **kwargs):
    if created:
        # Jika objek Pengguna baru dibuat, update id_pengguna pada Dosen dan Mahasiswa
        Dosen.objects.filter(id_pengguna=None).update(id_pengguna=instance)
        Mahasiswa.objects.filter(id_pengguna=None).update(id_pengguna=instance)

@api_view(['POST'])
def perwalian_post(request):
    if request.method == 'POST':
        # Ambil ID dosen dari permintaan
        id_dosen = request.data.get('id_dosen')

        # Pastikan kedua field diisi
        if id_dosen is None:
            return Response({'error': 'Data tidak lengkap'}, status=status.HTTP_400_BAD_REQUEST)

        try:
            # Cek apakah id_dosen ada di database
            dosen = Dosen.objects.get(id_dosen=id_dosen)

            # Ambil ID mahasiswa dari permintaan
            id_mahasiswa_list = request.data.get('id_mahasiswa')

            if id_mahasiswa_list is None or not isinstance(id_mahasiswa_list, list):
                return Response({'error': 'ID mahasiswa harus berupa daftar'}, status=status.HTTP_400_BAD_REQUEST)

            # Lakukan query untuk mendapatkan mahasiswa perwalian
            mahasiswa_perwalian = Mahasiswa.objects.filter(id_mahasiswa__in=id_mahasiswa_list)
            mahasiswa_perwalian.update(id_dosen=dosen)
            serializer = MahasiswaSerializer(mahasiswa_perwalian, many=True)

            return Response({'data': serializer.data, 'message': 'Data perwalian berhasil dibuat'}, status=status.HTTP_200_OK)

        except Dosen.DoesNotExist:
            return Response({'error': 'ID dosen tidak ditemukan'}, status=status.HTTP_400_BAD_REQUEST)
        
@api_view(['DELETE'])
def perwalian_delete(request, id_dosen, id_mahasiswa):
    if request.method == 'DELETE':
        try:
            # Cari data perwalian berdasarkan id_mahasiswa dan id_dosen
            perwalian = Mahasiswa.objects.get(id_mahasiswa=id_mahasiswa, id_dosen=id_dosen)
            
            # Hapus kolom id_dosen
            perwalian.id_dosen = None
            perwalian.save()

            return Response({'message': 'Data perwalian berhasil dihapus'}, status=status.HTTP_200_OK)

        except Mahasiswa.DoesNotExist:
            return Response({'error': 'Data perwalian tidak ditemukan'}, status=status.HTTP_404_NOT_FOUND)

@api_view(['POST'])
def user_signup(request):
    if request.method == 'POST':
        username = request.data.get('username')
        password = request.data.get('password')
        role = request.data.get('role')

        # Cek apakah username sudah ada di database
        if Pengguna.objects.filter(username=username).exists():
            return Response({'error': 'Username sudah digunakan'}, status=status.HTTP_400_BAD_REQUEST)

        # Buat objek user baru
        pengguna = Pengguna.objects.create(
            username=username,
            password=make_password(password),  # hash password sebelum disimpan
            role=role
        )

        data = {
            'data': {
                'id': pengguna.id_pengguna,
                'username': pengguna.username,
                'role': pengguna.role
            },
            'message': 'Berhasil signup'
        }
        
        return Response(data, status=status.HTTP_201_CREATED)

@api_view(['POST'])
def user_login(request):
    if request.method == 'POST':
        username = request.data.get('username')
        password = request.data.get('password')

        # Ambil data pengguna dari model berdasarkan username
        pengguna = Pengguna.objects.filter(username=username).first()

        if pengguna:
            # Jika pengguna ditemukan, lakukan autentikasi dengan password yang diberikan
            if check_password(password, pengguna.password):
                # Jika password cocok, ambil data tambahan terkait dari tabel terkait
                if pengguna.role == 'mahasiswa':
                    mahasiswa = Mahasiswa.objects.filter(id_pengguna=pengguna).first()
                    data = {
                        'data': {
                            'id_pengguna': pengguna.id_pengguna,
                            'username': pengguna.username,
                            'role': pengguna.role,
                            'nama_mahasiswa': mahasiswa.nama if mahasiswa else None,
                            'id_mahasiswa': mahasiswa.id_mahasiswa if mahasiswa else None,
                            'ips': mahasiswa.ips if mahasiswa else None,
                            'ipk': mahasiswa.ipk if mahasiswa else None,
                            'sk2pm': mahasiswa.sk2pm if mahasiswa else None,
                            'foto_mahasiswa': mahasiswa.foto_mahasiswa.url if mahasiswa else None,
                            # Tambahkan data tambahan lainnya dari tabel Mahasiswa jika diperlukan
                        },
                        'message': 'Berhasil login'
                    }
                elif pengguna.role == 'dosen':
                    dosen = Dosen.objects.filter(id_pengguna=pengguna).first()
                    data = {
                        'data': {
                            'id_pengguna': pengguna.id_pengguna,
                            'username': pengguna.username,
                            'role': pengguna.role,
                            'nama_dosen': dosen.nama_dosen if dosen else None,
                            'id_dosen': dosen.id_dosen if dosen else None,
                            'nip': dosen.nip if dosen else None,
                            'foto_dosen': dosen.foto_dosen.url if dosen else None,
                            # Tambahkan data tambahan lainnya dari tabel Dosen jika diperlukan
                        },
                        'message': 'Berhasil login'
                    }
                elif pengguna.role == 'admin':
                    admins = Admins.objects.filter(id_pengguna=pengguna).first()
                    data = {
                        'data': {
                            'id_pengguna': pengguna.id_pengguna,
                            'username': pengguna.username,
                            'role': pengguna.role,
                            'nama_admin': admins.nama_admin if admins else None,
                            # Tambahkan data tambahan lainnya dari tabel Admins jika diperlukan
                        },
                        'message': 'Berhasil login'
                    }
                else:
                    # Jika role tidak dikenali, kembalikan respon dengan pesan error
                    return Response({'error': 'Role pengguna tidak valid'}, status=status.HTTP_400_BAD_REQUEST)

                return Response(data, status=status.HTTP_200_OK)
            else:
                # Jika password tidak cocok, kembalikan respon gagal autentikasi
                return Response({'error': 'Login gagal. Password salah.'}, status=status.HTTP_401_UNAUTHORIZED)
        else:
            # Jika pengguna tidak ditemukan, kembalikan respon gagal autentikasi
            return Response({'error': 'Login gagal. Pengguna tidak ditemukan.'}, status=status.HTTP_401_UNAUTHORIZED)

@api_view(['POST'])
def user_logout(request):
    if request.method == 'POST':
        logout(request)
        return Response({'message': 'Logout berhasil'}, status=status.HTTP_200_OK)