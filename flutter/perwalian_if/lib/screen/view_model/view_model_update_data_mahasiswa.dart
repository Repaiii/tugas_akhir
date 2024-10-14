import 'package:flutter/material.dart';
import 'package:flutter_admin_perwalian_if/model/model_fetch_mahasiswa.dart';
import 'package:flutter_admin_perwalian_if/services/service_mahasiswa.dart';

class ViewModelUpdateDataMahasiswa with ChangeNotifier {
  final service = MahasiswaService();
  ModelFetchMahasiswa? modelFetchMahasiswa;
  final formKey = GlobalKey<FormState>();
  final TextEditingController ips = TextEditingController();
  final TextEditingController ipk = TextEditingController();
  final TextEditingController skpm = TextEditingController();
  bool isLoading = true;
  void clearAll() {
    ips.clear();
    ipk.clear();
    skpm.clear();
    notifyListeners();
  }

  Future fetchMahasiswa({
    required int id,
  }) async {
    isLoading = false;
    modelFetchMahasiswa = await service.fetchMahasiswa(
      id: id,
    );
    isLoading = true;
    notifyListeners();
  }

  Future updateDataMahasiswa({
    required int id,
  }) async {
    double? dataIps =
        ips.text.isNotEmpty ? double.parse(ips.text) : modelFetchMahasiswa!.ips;
    double? dataIpk =
        ipk.text.isNotEmpty ? double.parse(ipk.text) : modelFetchMahasiswa!.ipk;
    int? dataSk2Pm = skpm.text.isNotEmpty
        ? int.parse(skpm.text)
        : modelFetchMahasiswa!.sk2Pm;
    isLoading = false;
    modelFetchMahasiswa = await service.updateDataMahasiswa(
      ips: dataIps,
      ipk: dataIpk,
      sk2pm: dataSk2Pm,
      id: id,
    );
    isLoading = true;
    clearAll();
    notifyListeners();
  }

  String? validateIpk(String value) {
    double? ipk;
    try {
      if (value.startsWith('.')) {
        return 'IPK tidak boleh dimulai dengan titik';
      }

      ipk = double.parse(value);
    } catch (e) {
      return null;
    }
    if (ipk < 0.0 || ipk > 4.0) {
      return 'IPK harus dalam rentang 0.0 hingga 4.0';
    }

    return null;
  }

  String? validateIps(String value) {
    double? ips;
    try {
      if (value.startsWith('.')) {
        return 'IPS tidak boleh dimulai dengan titik';
      }

      ips = double.parse(value);
    } catch (e) {
      return null;
    }
    if (ips < 0.0 || ips > 4.0) {
      return 'IPS harus dalam rentang 0.0 hingga 4.0';
    }

    return null;
  }
}
