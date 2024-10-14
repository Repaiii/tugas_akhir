// ignore_for_file: deprecated_member_use

import 'package:dio/dio.dart';
import 'package:flutter_admin_perwalian_if/model/model_fetch_mahasiswa_by_id.dart';

import '../model/model_fetch_detail_dosen.dart';
import '../utils/utils.dart';

class DosenService {
  final Dio _dio = Dio();

  Future<ModelFetchDetailDosen> fetchDetailDosen({
    required int id,
  }) async {
    try {
      final response = await _dio.get(
        "${Urls.baseUrl + Urls.fetchDetailDosen}$id/",
      );
      return ModelFetchDetailDosen.fromJson(response.data);
    } on DioError catch (_) {
      rethrow;
    }
  }

    Future<ModelFetchMahasiswaById> fetchMahasiswaById({
    required int id,
  }) async {
    try {
      final response = await _dio.get(
        "${Urls.baseUrl + Urls.fetchMahasiswa}$id/",
      );
      return ModelFetchMahasiswaById.fromJson(response.data);
    } on DioError catch (_) {
      rethrow;
    }
  }
}
