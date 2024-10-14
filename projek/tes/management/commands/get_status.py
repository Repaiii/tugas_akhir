from django.core.management.base import BaseCommand
from tes.models import Mahasiswa
import pandas as pd
import mysql.connector
from mysql.connector import Error

class Command(BaseCommand):
    help = 'Update status mahasiswa based on calculated values'

    def handle(self, *args, **kwargs):
        connection = mysql.connector.connect(
           host="127.0.0.1",
           user="root",
           password="",
           database="coba"
        )
        
        query = """SELECT Mahasiswa.Nama, Mahasiswa.IPS, Mahasiswa.IPK, Mahasiswa.SK2PM, Mahasiswa.Pembayaran_UKT, Mahasiswa.Semester, 
                    Bobot.bobot_IPS, Bobot.bobot_IPK, Bobot.bobot_SK2PM, Bobot.bobot_UKT, Bobot.bobot_SMT FROM Mahasiswa, Bobot;"""
        df = pd.read_sql(query, connection)
        
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
            if x <= 1000:
                return 1
            elif 1000 < x < 2000:
                return (2000 - x) / 1000
            else:
                return 0

        def fuzzy_membership_rendah_sk2pm(x):
            if x <= 1000 or x >= 3000:
                return 0
            elif 1000 < x <= 2000:
                return (x - 1000) / 1000
            elif 2000 < x < 3000:
                return (3000 - x) / 1000

        def fuzzy_membership_cukup_sk2pm(x):
            if x <= 2000 or x >= 4000:
                return 0
            elif 2000 < x <= 3000:
                return (x - 2000) / 1000
            elif 3000 < x < 4000:
                return (4000 - x) / 1000

        def fuzzy_membership_tinggi_sk2pm(x):
            if x <= 3000 or x >= 5000:
                return 0
            elif 3000 < x <= 4000:
                return (x - 3000) / 1000
            elif 4000 < x < 5000:
                return (5000 - x) / 1000

        def fuzzy_membership_sangat_tinggi_sk2pm(x):
            if x <= 4000:
                return 0
            elif 4000 < x <= 5000:
                return (x - 4000) / 1000
            else:
                return 1
        
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
        
        #Fungsi perhitungan himpunan fuzzy untuk Semester
        def fuzzy_membership_skor_semester(x):
            return 1 if x > 8 else 2
        
        # Menambahkan kolom Fuzzy_IPS ke dalam dataframe
        df['Sangat_Rendah'] = df['IPS'].apply(fuzzy_membership_sangat_rendah)
        df['Rendah'] = df['IPS'].apply(fuzzy_membership_rendah)
        df['Cukup'] = df['IPS'].apply(fuzzy_membership_cukup)
        df['Tinggi'] = df['IPS'].apply(fuzzy_membership_tinggi)
        df['Sangat_Tinggi'] = df['IPS'].apply(fuzzy_membership_sangat_tinggi)
        df['Keterangan'] = df[['Sangat_Rendah', 'Rendah', 'Cukup', 'Tinggi', 'Sangat_Tinggi']].idxmax(axis=1).apply(lambda x: x.replace('_IPS', ''))
        
        # Mapping skor untuk kriteria IPS
        skor_mapping_ips = {
            'Sangat_Rendah': 1,
            'Rendah': 2,
            'Cukup': 3,
            'Tinggi': 4,
            'Sangat_Tinggi': 5
            }
        
        # Menambahkan kolom Nilai_IPS ke dalam dataframe
        df['Skor'] = df[['Sangat_Rendah', 'Rendah', 'Cukup', 'Tinggi', 'Sangat_Tinggi']].idxmax(axis=1)
        df['Skor_IPS'] = df['Skor'].apply(lambda x: skor_mapping_ips[x.replace('_IPS', '')])
        
        # Menambahkan kolom Fuzzy_IPK ke dalam dataframe
        df['Sangat_Rendah'] = df['IPK'].apply(fuzzy_membership_sangat_rendah)
        df['Rendah'] = df['IPK'].apply(fuzzy_membership_rendah)
        df['Cukup'] = df['IPK'].apply(fuzzy_membership_cukup)
        df['Tinggi'] = df['IPK'].apply(fuzzy_membership_tinggi)
        df['Sangat_Tinggi'] = df['IPK'].apply(fuzzy_membership_sangat_tinggi)
        df['Keterangan'] = df[['Sangat_Rendah', 'Rendah', 'Cukup', 'Tinggi', 'Sangat_Tinggi']].idxmax(axis=1).apply(lambda x: x.replace('_IPK', ''))
        
        # Mapping skor untuk kriteria IPK
        skor_mapping_ipk = {
            'Sangat_Rendah': 1,
            'Rendah': 2,
            'Cukup': 3,
            'Tinggi': 4,
            'Sangat_Tinggi': 5
            }
        
        # Menambahkan kolom Nilai_IPK ke dalam dataframe
        df['Skor'] = df[['Sangat_Rendah', 'Rendah', 'Cukup', 'Tinggi', 'Sangat_Tinggi']].idxmax(axis=1)
        df['Skor_IPK'] = df['Skor'].apply(lambda x: skor_mapping_ips[x.replace('_IPS', '')])
        
        # Menambahkan kolom Fuzzy_SK2PM ke dalam dataframe
        df['Sangat_Rendah_SK2PM'] = df['SK2PM'].apply(fuzzy_membership_sangat_rendah_sk2pm)
        df['Rendah_SK2PM'] = df['SK2PM'].apply(fuzzy_membership_rendah_sk2pm)
        df['Cukup_SK2PM'] = df['SK2PM'].apply(fuzzy_membership_cukup_sk2pm)
        df['Tinggi_SK2PM'] = df['SK2PM'].apply(fuzzy_membership_tinggi_sk2pm)
        df['Sangat_Tinggi_SK2PM'] = df['SK2PM'].apply(fuzzy_membership_sangat_tinggi_sk2pm)
        
        # Menggunakan nilai fuzzy terbesar untuk menentukan keterangan
        df['Keterangan'] = df[['Sangat_Rendah_SK2PM', 'Rendah_SK2PM', 'Cukup_SK2PM', 'Tinggi_SK2PM', 'Sangat_Tinggi_SK2PM']].idxmax(axis=1)
        df['Keterangan'] = df['Keterangan'].apply(lambda x: x.replace('_SK2PM', ''))
        
        # Mapping skor untuk kriteria SK2PM
        skor_mapping_sk2pm = {
            'Sangat_Rendah': 1,
            'Rendah': 2,
            'Cukup': 3,
            'Tinggi': 4,
            'Sangat_Tinggi': 5
            }
        
        # Menambahkan kolom Nilai_SK2PM ke dalam dataframe
        df['Skor_SK2PM'] = df['Keterangan'].apply(lambda x: skor_mapping_sk2pm[x])
        
        # Menambahkan kolom Skor_UKT ke dalam dataframe
        df['Skor_UKT'] = df['Pembayaran_UKT'].apply(lambda x: 2 if x == 'Sudah Bayar' else 1)
        
        # Menambahkan kolom Skor_Semester ke dalam dataframe
        df['Skor_SMT'] = df['Semester'].apply(fuzzy_membership_skor_semester)
        
        # Menampilkan matrks x
        matriks_x = df[['Nama', 'Skor_IPS', 'Skor_IPK', 'Skor_SK2PM', 'Skor_UKT', 'Skor_SMT']]
        
        # Normalisasi matriks X
        df_normalized = matriks_x.copy()
        for col in matriks_x.columns[1:]:
            # Menggunakan nilai kolom dibagi nilai maksimum kolom
            df_normalized[col] = df[col] / df[col].max()
        
        # Dataframe bobot kriteria
        bobot_data = {'Kriteria': ['K1', 'K2', 'K3', 'K4', 'K5'],
                      'Bobot (angka)': [df['bobot_IPS'].values[0],
                                        df['bobot_IPK'].values[0],
                                        df['bobot_SK2PM'].values[0],
                                        df['bobot_UKT'].values[0],
                                        df['bobot_SMT'].values[0]]}
        df_bobot = pd.DataFrame(bobot_data)
        
        # Menghitung nilai V untuk tiap alternatif
        df_normalized['Nilai_V'] = (df_normalized['Skor_IPS'] * df_bobot.set_index('Kriteria')['Bobot (angka)']['K1'] +
                                    df_normalized['Skor_IPK'] * df_bobot.set_index('Kriteria')['Bobot (angka)']['K2'] +
                                    df_normalized['Skor_SK2PM'] * df_bobot.set_index('Kriteria')['Bobot (angka)']['K3'] +
                                    df_normalized['Skor_UKT'] * df_bobot.set_index('Kriteria')['Bobot (angka)']['K4'] +
                                    df_normalized['Skor_SMT'] * df_bobot.set_index('Kriteria')['Bobot (angka)']['K5'])
        df_ranking = df_normalized.sort_values(by='Nilai_V')
        
        # Menambahkan kolom Status_Mahasiswa ke dalam dataframe
        df_normalized['Bahaya'] = df_normalized['Nilai_V'].apply(fuzzy_membership_bahaya)
        df_normalized['Cukup'] = df_normalized['Nilai_V'].apply(fuzzy_membership_sedang)
        df_normalized['Aman'] = df_normalized['Nilai_V'].apply(fuzzy_membership_aman)
        
        # Menambahkan kolom Status ke dalam dataframe
        df_normalized['Status'] = df_normalized[['Bahaya', 'Cukup', 'Aman']].idxmax(axis=1).apply(lambda x: x.replace('fuzzy_membership_', ''))
        
        # Mengurutkan dataframe berdasarkan kolom 'Status'
        df_sorted_status = df_normalized.sort_values(by='Status')
        
        # Membuat koneksi ke database
        try:
            connection = mysql.connector.connect(
                host="127.0.0.1",
                user="root",
                password="",
                database="coba"
            )

            if connection.is_connected():
                cursor = connection.cursor()

                # Ambil data Mahasiswa dari database
                query = "SELECT Nama, IPS, IPK, SK2PM, Pembayaran_UKT, Semester FROM Mahasiswa"
                df = pd.read_sql(query, connection)

                # Loop melalui setiap baris data dalam DataFrame dan perbarui nilai Status di database
                for index, row in df_normalized.iterrows():
                    # Ambil nama mahasiswa dan nilai status dari DataFrame
                    nama = row['Nama']
                    status = row['Status']

                    # Perbarui nilai Status di database
                    update_query = "UPDATE Mahasiswa SET Status = %s WHERE Nama = %s"
                    cursor.execute(update_query, (status, nama))

                # Commit perubahan
                connection.commit()
                self.stdout.write(self.style.SUCCESS('Status berhasil diperbarui di database.'))

        except Error as e:
            self.stdout.write(self.style.ERROR(f'Terjadi kesalahan: {e}'))

        finally:
            # Tutup koneksi dan cursor
            if connection.is_connected():
                cursor.close()
                connection.close()
                self.stdout.write(self.style.SUCCESS('Koneksi ke database ditutup.'))