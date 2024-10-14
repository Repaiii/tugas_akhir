// ignore_for_file: deprecated_member_use

import 'package:dio/dio.dart';

import '../model/model_fetch_mahasiswa.dart';
import '../utils/utils.dart';

class MahasiswaService {
  final Dio _dio = Dio();

  Future<ModelFetchMahasiswa> fetchMahasiswa({
    required int id,
  }) async {
    try {
      final response = await _dio.get(
        "${Urls.baseUrl + Urls.fetchMahasiswa}$id/"
      
      );
      return ModelFetchMahasiswa.fromJson(response.data);
    } on DioError catch (_) {
      rethrow;
    }
  }

    Future<ModelFetchMahasiswa> updateDataMahasiswa({
    required double ips,
    required double ipk,
    required int sk2pm,
    required int id,
  }) async {
    try {
      final response = await _dio.put(
        "${Urls.baseUrl + Urls.fetchMahasiswa}$id/",
        data: {
          'ips': ips,
          'ipk': ipk,
          'sk2pm': sk2pm,
        },
      );
      return ModelFetchMahasiswa.fromJson(response.data);
    } on DioError catch (_) {
      rethrow;
    }
  }
}