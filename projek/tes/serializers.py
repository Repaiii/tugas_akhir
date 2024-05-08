from rest_framework import serializers
from .models import Dosen, Mahasiswa, Admins, Pengguna

class DosenSerializer(serializers.ModelSerializer):
    class Meta:
        model = Dosen
        fields = '__all__'

class MahasiswaSerializer(serializers.ModelSerializer):
    class Meta:
        model = Mahasiswa
        fields = '__all__'

class AdminsSerializer(serializers.ModelSerializer):
    class Meta:
        model = Admins
        fields = '__all__'

class PenggunaSerializer(serializers.ModelSerializer):
    class Meta:
        model = Pengguna
        fields = '__all__'