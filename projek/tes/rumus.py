from .models import Mahasiswa

semua_mahasiswa = Mahasiswa.objects.all()

# Fungsi perhitungan himpunan fuzzy untuk IPS & IPK
def fuzzy_membership_sangat_rendah(x):
    if x <= 2.75:
        return 1
    elif 2.75 < x <= 3.00:
        return (3 - x) / 0.25
    else:
        return 0
    
def fuzzy_membership_rendah(x):
    if x <= 2.75 or x > 3.25:
        return 0
    elif 2.75 < x <= 3.00:
        return (x - 2.75) / 0.25
    elif 3.00 < x <= 3.25:
        return (3.25 - x) / 0.25
    
def fuzzy_membership_cukup(x):
    if x <= 3.00 or x > 3.50:
        return 0
    elif 3.00 < x <= 3.25:
        return (x - 3) / 0.25
    elif 3.25 < x <= 3.50:
        return (3.50 - x) / 0.25
    
def fuzzy_membership_tinggi(x):
    if x <= 3.25 or x > 3.75:
        return 0
    elif 3.25 < x <= 3.50:
        return (x - 3.25) / 0.25
    elif 3.50 < x <= 3.75:
        return (3.75 - x) / 0.25
    
def fuzzy_membership_sangat_tinggi(x):
    if x <= 3.50:
        return 0
    elif 3.50 < x <= 3.75:
        return (x - 3.50) / 0.25
    else:
        return 1

# Fungsi perhitungan himpunan fuzzy untuk SK2PM
def fuzzy_membership_sangat_rendah_sk2pm(x):
    if x < 1500:
        return 1
    elif 1500 <= x < 3000:
        return (3000 - x) / 1500
    else:
        return 0

def fuzzy_membership_rendah_sk2pm(x):
    if x < 1500 or x >= 3000:
        return 0
    elif 1500 <= x < 3000:
        return (x - 1500) / 1500

def fuzzy_membership_cukup_sk2pm(x):
    if x < 3000 or x >= 4500:
        return 0
    elif 3000 <= x < 4500:
        return (x - 3000) / 1500

def fuzzy_membership_tinggi_sk2pm(x):
    if x < 4500 or x >= 6000:
        return 0
    elif 4500 <= x < 6000:
        return (x - 4500) / 1500

def fuzzy_membership_sangat_tinggi_sk2pm(x):
    if x < 6000:
        return 0
    else:
        return 1

# Fungsi perhitungan himpunan fuzzy untuk UKT
def fuzzy_membership_ukt(x):
    if x == 'Sudah Bayar':
        return 2
    else:
        return 1

#Fungsi perhitungan himpunan fuzzy untuk Semester
def fuzzy_membership_semester(x):
    return 1 if x > 8 else 2

# Fungsi perhitungan himpunan fuzzy untuk Status Mahasiswa
def fuzzy_membership_bahaya(x):
    if x <= 0.5:
        return 1
    elif 0.5 < x <= 0.75:
        return (0.75 - x) / 0.25
    else:
        return 0

def fuzzy_membership_sedang(x):
    if x <= 0.5 or x > 0.75:
        return 0
    else:
        return (x - 0.5) / 0.25

def fuzzy_membership_aman(x):
    if x <= 0.75:
        return 0
    else:
        return 1

for mahasiswa in semua_mahasiswa:
    # Ambil data yang dibutuhkan dari setiap objek mahasiswa
    ips = mahasiswa.ips
    ipk = mahasiswa.ipk
    sk2pm = mahasiswa.sk2pm
    pembayaran_ukt = mahasiswa.pembayaran_ukt
    semester = mahasiswa.semester

    # Hitung fuzzy score untuk setiap kriteria IPS
    sangat_rendah_ips = fuzzy_membership_sangat_rendah(ips)
    rendah_ips = fuzzy_membership_rendah(ips)
    cukup_ips = fuzzy_membership_cukup(ips)
    tinggi_ips = fuzzy_membership_tinggi(ips)
    sangat_tinggi_ips = fuzzy_membership_sangat_tinggi(ips)
    
    keterangan_ips = max(sangat_rendah_ips, rendah_ips, cukup_ips, tinggi_ips, sangat_tinggi_ips)
    skor_mapping_ips = {
        'Sangat_Rendah': 1,
        'Rendah': 2,
        'Cukup': 3,
        'Tinggi': 4,
        'Sangat_Tinggi': 5
    }
    
    skor_ips = max(skor_mapping_ips, key=lambda k: skor_mapping_ips[k])

    
    # Hitung fuzzy score untuk setiap kriteria IPK
    sangat_rendah_ipk = fuzzy_membership_sangat_rendah(ipk)
    rendah_ipk = fuzzy_membership_rendah(ipk)
    cukup_ipk = fuzzy_membership_cukup(ipk)
    tinggi_ipk = fuzzy_membership_tinggi(ipk)
    sangat_tinggi_ipk = fuzzy_membership_sangat_tinggi(ipk)
    
    keterangan_ipk = max(sangat_rendah_ipk, rendah_ipk, cukup_ipk, tinggi_ipk, sangat_tinggi_ipk)
    
    skor_mapping_ipk = {
        'Sangat_Rendah': 1,
        'Rendah': 2,
        'Cukup': 3,
        'Tinggi': 4,
        'Sangat_Tinggi': 5
    }
    
    skor_ipk = max(skor_mapping_ipk, key=lambda k: skor_mapping_ipk[k])
    
    # Hitung fuzzy score untuk setiap kriteria SK2PM
    sangat_rendah_sk2pm = fuzzy_membership_sangat_rendah_sk2pm(sk2pm)
    rendah_sk2pm = fuzzy_membership_rendah_sk2pm(sk2pm)
    cukup_sk2pm = fuzzy_membership_cukup_sk2pm(sk2pm)
    tinggi_sk2pm = fuzzy_membership_tinggi_sk2pm(sk2pm)
    sangat_tinggi_sk2pm = fuzzy_membership_sangat_tinggi_sk2pm(sk2pm)
    
    keterangan_sk2pm  = max(sangat_rendah_sk2pm , rendah_sk2pm , cukup_sk2pm , tinggi_sk2pm , sangat_tinggi_sk2pm )
    
    skor_mapping_sk2pm = {
        'Sangat_Rendah': 1,
        'Rendah': 2,
        'Cukup': 3,
        'Tinggi': 4,
        'Sangat_Tinggi': 5
    }
    
    skor_sk2pm = max(skor_mapping_sk2pm, key=lambda k: skor_mapping_sk2pm[k])
    
    # Hitung fuzzy score untuk setiap kriteria ukt
    skor_ukt = fuzzy_membership_ukt(pembayaran_ukt)
    
    # Hitung fuzzy score untuk setiap kriteria semester
    skor_semester = fuzzy_membership_semester(semester)

# buat matriks x
matriks_x = [skor_ips, skor_ipk, skor_sk2pm, skor_ukt, skor_semester]

# Buat matriks normalisasi sebagai salinan dari matriks_x
matriks_normalized = [kolom[:] for kolom in matriks_x]

# Iterasi setiap kolom dalam matriks_x
for i in range(len(matriks_x)):
    kolom = matriks_x[i]
    max_value = max(kolom)
    min_value = min(kolom)
    
    # Iterasi setiap nilai dalam kolom
    for j in range(len(kolom)):
        # Lakukan normalisasi berdasarkan kondisi
        if max_value == min_value:
            # Hindari pembagian dengan nol
            matriks_normalized[i][j] = 1.0
        elif i == len(matriks_x) - 1:
            # Normalisasi untuk kolom skor semester (atau kolom terakhir)
            matriks_normalized[i][j] = min_value / kolom[j]
        else:
            # Normalisasi untuk kolom lainnya
            matriks_normalized[i][j] = kolom[j] / max_value

# Definisikan bobot sebagai dictionary
bobot_data = {'Kriteria': ['K1', 'K2', 'K3', 'K4', 'K5'],
              'Bobot (angka)': [0.45, 0.25, 0.1, 0.05, 0.15]}

# Hitung nilai V untuk setiap alternatif
nilai_V = []
for i in range(len(matriks_normalized[0])):
    # Inisialisasi nilai V untuk setiap alternatif
    v_alternatif = 0
    for j in range(len(matriks_normalized)):
        # Hitung nilai V untuk setiap kriteria dan tambahkan ke nilai V alternatif
        v_alternatif += matriks_normalized[j][i] * bobot_data['Bobot (angka)'][j]
    nilai_V.append(v_alternatif)

# Gabungkan nilai V dengan matriks normalisasi
for i in range(len(matriks_normalized)):
    matriks_normalized[i].append(nilai_V[i])

# Sort matriks normalisasi berdasarkan nilai V
matriks_normalized_sorted = sorted(zip(*matriks_normalized), key=lambda x: x[-1])

# Inisialisasi matriks normalisasi dengan data dan nilai V
matriks_normalized = []

# Tambahkan kolom Status_Mahasiswa ke dalam matriks normalisasi
for i in range(len(nilai_V)):
    # Hitung Bahaya, Sedang, dan Aman untuk setiap nilai V
    bahaya = fuzzy_membership_bahaya(nilai_V[i][0])
    sedang = fuzzy_membership_sedang(nilai_V[i][0])
    aman = fuzzy_membership_aman(nilai_V[i][0])
    
    # Tentukan status berdasarkan nilai Bahaya, Sedang, dan Aman
    status = max(bahaya, sedang, aman)
    if status == bahaya:
        status = 'Bahaya'
    elif status == sedang:
        status = 'Sedang'
    else:
        status = 'Aman'
    
    # Tambahkan data ke matriks normalisasi
    matriks_normalized.append([nilai_V[i][0], bahaya, sedang, aman, status])

# Sort matriks normalisasi berdasarkan nilai V
matriks_normalized_sorted = sorted(matriks_normalized, key=lambda x: x[0])

Mahasiswa.status = status
Mahasiswa.save