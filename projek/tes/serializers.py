from rest_framework import serializers
from .models import Dosen, Mahasiswa, Admins, Pengguna

class DosenSerializer(serializers.ModelSerializer):
    mahasiswa_perwalian = serializers.SerializerMethodField()
    id_pengguna = serializers.PrimaryKeyRelatedField(read_only=True)

    class Meta:
        model = Dosen
        fields = [
            'id_dosen',
            'nama_dosen',
            'nip',
            'foto_dosen',
            'id_pengguna',
            'mahasiswa_perwalian'
        ]
        
        extra_kwargs = {
            'foto_dosen': {'required': False}
        }

    def get_mahasiswa_perwalian(self, obj):
        mahasiswa = Mahasiswa.objects.filter(id_dosen=obj)
        return MahasiswaSerializer(mahasiswa, many=True).data

    def to_representation(self, instance):
        representation = super().to_representation(instance)
        mahasiswa_perwalian = representation.pop('mahasiswa_perwalian')
        representation['mahasiswa_perwalian'] = mahasiswa_perwalian
        return representation

class MahasiswaSerializer(serializers.ModelSerializer):
    class Meta:
        model = Mahasiswa
        fields = '__all__'
        
        extra_kwargs = {
            'foto_mahasiswa': {'required': False}
        }

class AdminsSerializer(serializers.ModelSerializer):
    class Meta:
        model = Admins
        fields = '__all__'

class PenggunaSerializer(serializers.ModelSerializer):
    class Meta:
        model = Pengguna
        fields = '__all__'