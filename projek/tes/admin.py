from django.contrib import admin
from .models import Admins, Bobot, Dosen, Mahasiswa, Pengguna

# Daftarkan model-model di admin site di bawah ini
admin.site.register(Admins)
admin.site.register(Bobot)
admin.site.register(Dosen)
admin.site.register(Mahasiswa)
admin.site.register(Pengguna)
