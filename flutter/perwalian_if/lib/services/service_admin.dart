// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_admin_perwalian_if/model/model_add_mahasiswa_di_dosen.dart';
import 'package:flutter_admin_perwalian_if/model/model_add_pengguna.dart';
import 'package:flutter_admin_perwalian_if/model/model_delete_dosen.dart';
import 'package:flutter_admin_perwalian_if/model/model_fetch_all_dosen.dart';
import 'package:flutter_admin_perwalian_if/model/model_fetch_all_mahasiswa.dart';
import 'package:flutter_admin_perwalian_if/model/model_fetch_detail_dosen.dart';
import 'package:flutter_admin_perwalian_if/model/model_fetch_mahasiswa_non_perwalian.dart';

import '../model/model_add_dosen.dart';
import '../model/model_delete_mahasiswa_di_dosen.dart';
import '../model/model_edit_dosen.dart';
import '../utils/utils.dart';

class AdminService {
  final Dio _dio = Dio();

  Future<ModelFetchAllDosen> fetchAllDosen() async {
    try {
      final response = await _dio.get(
        Urls.baseUrl + Urls.fetchAllDosen,
      );
      return ModelFetchAllDosen.fromJson(response.data);
    } on DioError catch (_) {
      rethrow;
    }
  }

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

  Future<ModelFetchAllMahasiswa> fetchAllMahasiswa() async {
    try {
      final response = await _dio.get(
        Urls.baseUrl + Urls.fetchMahasiswa,
      );
      return ModelFetchAllMahasiswa.fromJson(response.data);
    } on DioError catch (_) {
      rethrow;
    }
  }

  Future<ModelDeleteMahasiswadiDosen> deleteMahasiswaDiDosen({
    required int idDosen,
    required int idMhs,
  }) async {
    try {
      final response = await _dio.delete(
        "${Urls.baseUrl + Urls.deleteMahasiswadiDosen}$idDosen/$idMhs/",
      );
      return ModelDeleteMahasiswadiDosen.fromJson(response.data);
    } on DioError catch (_) {
      rethrow;
    }
  }

  Future<ModelAddDosen> addDosen({
    required File foto,
    required String nama,
    required String nip,
  }) async {
    try {
      final formData = FormData.fromMap({
        'nama_dosen': nama,
        'nip': nip,
        'foto_dosen': await MultipartFile.fromFile(
          foto.path,
          filename: 'photo.jpg',
        ),
      });
      final response = await _dio.post(
        Urls.baseUrl + Urls.addDosen,
        data: formData,
      );
      return ModelAddDosen.fromJson(response.data);
    } on DioError catch (_) {
      rethrow;
    }
  }

  Future<ModelAddPengguna> addDosenPengguna({
    required int idPengguna,
    required String nip,
    required String password,
  }) async {
    try {
      final response = await _dio.put(
        "${Urls.baseUrl + Urls.addPengguna}$idPengguna/",
        data: {
          'username': nip,
          'password': password,
        },
      );
      return ModelAddPengguna.fromJson(response.data);
    } on DioError catch (_) {
      rethrow;
    }
  }

  Future<ModelNonPerwalian> fetchMahasiswaNonPerwalian() async {
    try {
      final response = await _dio.get(
        Urls.baseUrl + Urls.fetchMhsNonPerwalian,
      );
      return ModelNonPerwalian.fromJson(response.data);
    } on DioError catch (_) {
      rethrow;
    }
  }

  Future<ModelAddMahasiswaDiDosen> addMahasiswaDiDosen({
    required int idDosen,
    required List<int> mahasiswaId,
  }) async {
    try {
      final response = await _dio.post(
        Urls.baseUrl + Urls.addMahasiswaDiDosen,
        data: {
          'id_dosen': idDosen,
          'id_mahasiswa': mahasiswaId,
        },
      );
      return ModelAddMahasiswaDiDosen.fromJson(response.data);
    } on DioError catch (_) {
      rethrow;
    }
  }

  Future<ModelEditDosen> editDosen({
    required int idDosen,
    required File foto,
    required String nama,
    required String nip,
  }) async {
    try {
      final formData = FormData.fromMap(
        {
          'nama_dosen': nama,
          'nip': nip,
          'foto_dosen': await MultipartFile.fromFile(
            foto.path,
            filename: 'photo.jpg',
          ),
        },
      );
      final response = await _dio.put(
        "${Urls.baseUrl + Urls.editDosen}$idDosen/",
        data: formData,
      );
      return ModelEditDosen.fromJson(response.data);
    } on DioError catch (_) {
      rethrow;
    }
  }

  Future<ModelEditDosen> editDosenTanpaFoto({
    required int idDosen,
    required String nama,
    required String nip,
  }) async {
    try {
      final formData = FormData.fromMap(
        {
          'nama_dosen': nama,
          'nip': nip,
        },
      );
      final response = await _dio.put(
        "${Urls.baseUrl + Urls.editDosen}$idDosen/",
        data: formData,
      );
      return ModelEditDosen.fromJson(response.data);
    } on DioError catch (_) {
      rethrow;
    }
  }

  Future<ModelDeleteDosen> deleteDosen({
    required int idDosen,
  }) async {
    try {
      final response = await _dio.delete(
        "${Urls.baseUrl + Urls.deleteDosen}$idDosen/",
      );
      return ModelDeleteDosen.fromJson(response.data);
    } on DioError catch (_) {
      rethrow;
    }
  }
}
