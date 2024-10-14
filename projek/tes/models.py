from django.db import models
from django.contrib.auth.models import AbstractUser


class Admins(models.Model):
    id_admin = models.AutoField(primary_key=True)
    nama_admin = models.CharField(max_length=50, blank=True, null=True)
    id_pengguna = models.ForeignKey('Pengguna', models.DO_NOTHING, db_column='id_pengguna', blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'admins'
        app_label = 'tes'

class Bobot(models.Model):
    id_bobot = models.AutoField(primary_key=True)
    bobot_ipk = models.FloatField(db_column='bobot_IPK', blank=True, null=True)
    bobot_sk2pm = models.FloatField(db_column='bobot_SK2PM', blank=True, null=True)
    bobot_ukt = models.FloatField(db_column='bobot_UKT', blank=True, null=True)
    bobot_semester = models.FloatField(blank=True, null=True)
    bobot_ips = models.FloatField(db_column='bobot_IPS', blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'bobot'
        app_label = 'tes'


class Dosen(models.Model):
    id_dosen = models.AutoField(primary_key=True)
    nama_dosen = models.CharField(max_length=50, blank=True, null=True)
    nip = models.CharField(max_length=50, blank=True, null=True)
    id_pengguna = models.ForeignKey('Pengguna', models.DO_NOTHING, db_column='id_pengguna', blank=True, null=True)
    foto_dosen = models.FileField(upload_to='foto-dosen')

    class Meta:
        managed = False
        db_table = 'dosen'
        app_label = 'tes'


class Mahasiswa(models.Model):
    id_mahasiswa = models.AutoField(primary_key=True)
    nama = models.CharField(max_length=50, blank=True, null=True)
    nim = models.CharField(max_length=50, blank=True, null=True)
    ips = models.FloatField(db_column='IPS', blank=True, null=True)
    ipk = models.FloatField(db_column='IPK', blank=True, null=True)
    sk2pm = models.IntegerField(db_column='SK2PM', blank=True, null=True)
    pembayaran_ukt = models.CharField(db_column='Pembayaran_UKT', max_length=11, blank=True, null=True)
    semester = models.IntegerField(blank=True, null=True)
    id_dosen = models.ForeignKey(Dosen, models.DO_NOTHING, db_column='id_dosen', blank=True, null=True)
    id_pengguna = models.ForeignKey('Pengguna', models.DO_NOTHING, db_column='id_pengguna', blank=True, null=True)
    foto_mahasiswa = models.FileField(upload_to='foto-mahasiswa')
    status = models.CharField(max_length=50, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'mahasiswa'
        app_label = 'tes'


class Pengguna(models.Model):
    id_pengguna = models.AutoField(primary_key=True)
    username = models.CharField(max_length=50, blank=True, null=True)
    password = models.CharField(max_length=100, blank=True, null=True)
    role = models.CharField(max_length=50, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'pengguna'
        app_label = 'tes'
