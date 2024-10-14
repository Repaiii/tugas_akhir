import 'package:flutter/material.dart';
import 'dart:io';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import 'package:flutter_admin_perwalian_if/model/model_delete_dosen.dart';
import 'package:flutter_admin_perwalian_if/model/model_delete_mahasiswa_di_dosen.dart';
import 'package:flutter_admin_perwalian_if/model/model_fetch_all_dosen.dart';
import 'package:flutter_admin_perwalian_if/model/model_fetch_all_mahasiswa.dart';
import 'package:flutter_admin_perwalian_if/model/model_fetch_detail_dosen.dart';
import 'package:flutter_admin_perwalian_if/model/model_fetch_mahasiswa_non_perwalian.dart';
import 'package:flutter_admin_perwalian_if/services/service_admin.dart';
import '../../model/model_add_mahasiswa_di_dosen.dart';

class ViewModelHome with ChangeNotifier {
  final service = AdminService();
  ModelFetchAllDosen? modelFetchAllDosen;
  ModelFetchDetailDosen? modelFetchDetailDosen;
  ModelFetchAllMahasiswa? modelFetchAllMahasiswa;
  ModelDeleteMahasiswadiDosen? modelDeleteMahasiswaDiDosen;
  ModelNonPerwalian? modelNonPerwalian;
  ModelAddMahasiswaDiDosen? modelAddMahasiswaDiDosen;
  ModelDeleteDosen? modelDeleteDosen;

  bool isLoading = false;
  bool isLoadingDetail = false;
  bool isLoadingNonPerwalian = false;
  List<int> selectedMahasiswaId = [];

  Future fetchAllDosen() async {
    modelFetchAllDosen = await service.fetchAllDosen();
    isLoading = true;
    notifyListeners();
  }

  Future fetchDetailDosen({
    required int id,
  }) async {
    isLoadingDetail = false;
    modelFetchDetailDosen = await service.fetchDetailDosen(
      id: id,
    );
    isLoadingDetail = true;
    notifyListeners();
  }

  void refresh({
    required int id,
  }) async {
    await fetchDetailDosen(
      id: id,
    );
  }

  Future fetchAllMahasiswa() async {
    modelFetchAllMahasiswa = await service.fetchAllMahasiswa();
    isLoading = true;
    notifyListeners();
  }

  Future deleteMahasiswaDiDosen({
    required int idDosen,
    required int idMhs,
  }) async {
    modelDeleteMahasiswaDiDosen = await service.deleteMahasiswaDiDosen(
      idDosen: idDosen,
      idMhs: idMhs,
    );
    notifyListeners();
  }

  Future fetchMahasiswaNonPerwalian() async {
    modelNonPerwalian = await service.fetchMahasiswaNonPerwalian();
    isLoadingNonPerwalian = true;
    notifyListeners();
  }

  void toggleSelection(int id) {
    if (selectedMahasiswaId.contains(id)) {
      selectedMahasiswaId.remove(id);
    } else {
      selectedMahasiswaId.add(id);
    }
    notifyListeners();
  }

  void clearSelection() {
    selectedMahasiswaId.clear();
    notifyListeners();
  }

  Future addMahasiswaDiDosen({
    required int idDosen,
  }) async {
    modelAddMahasiswaDiDosen = await service.addMahasiswaDiDosen(
      idDosen: idDosen,
      mahasiswaId: selectedMahasiswaId,
    );
    notifyListeners();
  }

  Future deleteDosen({
    required int idDosen,
  }) async {
    modelDeleteDosen = await service.deleteDosen(
      idDosen: idDosen,
    );
    notifyListeners();
  }

  Future<void> refreshDetailDosen({required int id}) async {
    await fetchDetailDosen(id: id);
  }

  String truncateText(String text) {
    if (text.length >= 10) {
      return '${text.substring(0, 5)}...';
    } else {
      return text;
    }
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'Aman':
        return const Color(0xFF1AC50B);
      case 'Cukup':
        return const Color(0xFFE5EA03);
      case 'Bahaya':
        return const Color(0xFFC50B0B);
      case '-':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  Future<void> downloadAllMahasiswaData() async {
    final pdf = pw.Document();
    final fontData = await rootBundle.load("assets/fonts/Roboto-Regular.ttf");
    final ttf = pw.Font.ttf(fontData);

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'Data Mahasiswa Informatika',
                style: pw.TextStyle(
                    font: ttf, fontSize: 20, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 20),
              pw.TableHelper.fromTextArray(
                headers: [
                  'NIM',
                  'Nama',
                  'IPS',
                  'IPK',
                  'SK2PM',
                  ' UKT',
                  'Semester',
                  'Status'
                ],
                data: List<List<String>>.generate(
                  modelFetchAllMahasiswa!.data.length,
                  (index) {
                    final mahasiswa = modelFetchAllMahasiswa!.data[index];
                    return [
                      mahasiswa.nim,
                      mahasiswa.nama,
                      mahasiswa.ips.toStringAsFixed(2),
                      mahasiswa.ipk.toStringAsFixed(2),
                      mahasiswa.sk2Pm.toString(),
                      mahasiswa.pembayaranUkt.toString(),
                      mahasiswa.semester.toString(),
                      mahasiswa.status,
                    ];
                  },
                ),
                cellStyle:
                    pw.TextStyle(font: ttf),
                headerStyle:
                    pw.TextStyle(font: ttf, fontWeight: pw.FontWeight.bold),
              ),
            ],
          );
        },
      ),
    );

    final output = await getExternalStorageDirectory();
    final filePath = "${output!.path}/data_mahasiswa.pdf";

    final file = File(filePath);
    await file.writeAsBytes(await pdf.save());

    await Printing.sharePdf(
        bytes: await pdf.save(), filename: 'data_mahasiswa.pdf');
  }
}
