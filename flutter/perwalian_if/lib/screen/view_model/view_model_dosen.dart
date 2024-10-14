import 'package:flutter/material.dart';
import 'package:flutter_admin_perwalian_if/model/model_fetch_mahasiswa_by_id.dart';
import 'package:flutter_admin_perwalian_if/services/service_dosen.dart';

import '../../model/model_fetch_detail_dosen.dart';

class ViewModelDosen with ChangeNotifier {
  final service = DosenService();
  ModelFetchDetailDosen? modelFetchDetailDosen;
  ModelFetchMahasiswaById? modelFetchMahasiswaById;
  bool isLoading = false;
  bool isLoadingDetailMhs = false;

  Future fetchDetailDosen({
    required int id,
  }) async {
    isLoading = false;
    modelFetchDetailDosen = await service.fetchDetailDosen(
      id: id,
    );
    isLoading = true;
    notifyListeners();
  }

  Future fetchMahasiswaById({
    required int id,
  }) async {
    isLoadingDetailMhs = false;
    modelFetchMahasiswaById = await service.fetchMahasiswaById(
      id: id,
    );
    isLoadingDetailMhs = true;
    notifyListeners();
  }

  double? getLowestIps() {
    if (modelFetchDetailDosen == null ||
        modelFetchDetailDosen!.mahasiswaPerwalian.isEmpty) {
      return null;
    }

    return modelFetchDetailDosen!.mahasiswaPerwalian
        .map((m) => m.ips)
        .reduce((value, element) => value < element ? value : element);
  }

  double? getHighestIps() {
    if (modelFetchDetailDosen == null ||
        modelFetchDetailDosen!.mahasiswaPerwalian.isEmpty) {
      return null;
    }

    return modelFetchDetailDosen!.mahasiswaPerwalian
        .map((m) => m.ips)
        .reduce((value, element) => value > element ? value : element);
  }

  double? getLowestIpk() {
    if (modelFetchDetailDosen == null ||
        modelFetchDetailDosen!.mahasiswaPerwalian.isEmpty) {
      return null;
    }

    return modelFetchDetailDosen!.mahasiswaPerwalian
        .map((m) => m.ipk)
        .reduce((value, element) => value < element ? value : element);
  }

  double? getHighestIpk() {
    if (modelFetchDetailDosen == null ||
        modelFetchDetailDosen!.mahasiswaPerwalian.isEmpty) {
      return null;
    }

    return modelFetchDetailDosen!.mahasiswaPerwalian
        .map((m) => m.ipk)
        .reduce((value, element) => value > element ? value : element);
  }

  int? getLowestSkpm() {
    if (modelFetchDetailDosen == null ||
        modelFetchDetailDosen!.mahasiswaPerwalian.isEmpty) {
      return null;
    }

    return modelFetchDetailDosen!.mahasiswaPerwalian
        .map((m) => m.sk2Pm)
        .reduce((value, element) => value < element ? value : element);
  }

  int? getHighestSkpm() {
    if (modelFetchDetailDosen == null ||
        modelFetchDetailDosen!.mahasiswaPerwalian.isEmpty) {
      return null;
    }

    return modelFetchDetailDosen!.mahasiswaPerwalian
        .map((m) => m.sk2Pm)
        .reduce((value, element) => value > element ? value : element);
  }

  int? getLowestSemester() {
    if (modelFetchDetailDosen == null ||
        modelFetchDetailDosen!.mahasiswaPerwalian.isEmpty) {
      return null;
    }

    return modelFetchDetailDosen!.mahasiswaPerwalian
        .map((m) => m.semester)
        .reduce((value, element) => value < element ? value : element);
  }

  int? getHighestSemester() {
    if (modelFetchDetailDosen == null ||
        modelFetchDetailDosen!.mahasiswaPerwalian.isEmpty) {
      return null;
    }

    return modelFetchDetailDosen!.mahasiswaPerwalian
        .map((m) => m.semester)
        .reduce((value, element) => value > element ? value : element);
  }

  int getTotalMahasiswa() {
    if (modelFetchDetailDosen == null) {
      return 0;
    }

    return modelFetchDetailDosen!.mahasiswaPerwalian.length;
  }

  int getTotalMahasiswaBahaya() {
    if (modelFetchDetailDosen == null) {
      return 0;
    }

    return modelFetchDetailDosen!.mahasiswaPerwalian
        .where((m) => m.status == "Bahaya")
        .length;
  }

  int getTotalMahasiswaCukup() {
    if (modelFetchDetailDosen == null) {
      return 0;
    }

    return modelFetchDetailDosen!.mahasiswaPerwalian
        .where((m) => m.status == "Cukup")
        .length;
  }

  int getTotalMahasiswaAman() {
    if (modelFetchDetailDosen == null) {
      return 0;
    }

    return modelFetchDetailDosen!.mahasiswaPerwalian
        .where((m) => m.status == "Aman")
        .length;
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
}
