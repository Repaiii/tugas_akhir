import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_admin_perwalian_if/model/model_edit_dosen.dart';
import 'package:image_picker/image_picker.dart';

import '../../model/model_fetch_detail_dosen.dart';
import '../../services/service_admin.dart';

class ViewModelEditDosen with ChangeNotifier {
  final service = AdminService();
  ModelFetchDetailDosen? modelFetchDetailDosen;
  ModelEditDosen? modelEditDosen;
  final formKey = GlobalKey<FormState>();
  final TextEditingController nama = TextEditingController();
  final TextEditingController nip = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool isPasswordVisible = false;
  File? imageFile;
  String? imagePath;
  bool fotoLebihLimaMB = false;
  bool isLoading = false;

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }

  String? validateUsername(String value) {
    if (value.isEmpty) {
      return 'Username tidak boleh kosong';
    }
    notifyListeners();
    return null;
  }

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return 'Kata sandi tidak boleh kosong';
    }
    notifyListeners();
    return null;
  }

  Future<void> pickImage() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      final File newImageFile = File(pickedImage.path);
      final int fileSizeInBytes = await newImageFile.length();
      const int maxSizeInBytes = 5 * 1024 * 1024;

      if (fileSizeInBytes > maxSizeInBytes) {
        fotoLebihLimaMB = true;
      } else {
        fotoLebihLimaMB = false;
        imageFile = newImageFile;
        imagePath = pickedImage.path;
      }
    } else {
      imageFile = File('');
      imagePath = null;
      fotoLebihLimaMB = false;
    }
    notifyListeners();
  }

  void clearAll() {
    nama.clear();
    nip.clear();
    password.clear();
    imageFile = null;
    imagePath = null;
    fotoLebihLimaMB = false;
    notifyListeners();
  }

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

  Future editDosen({
    required int id,
  }) async {
    String? nipDosen =
        nip.text.isNotEmpty ? nip.text : modelFetchDetailDosen!.nip;
    String? namaDosen =
        nama.text.isNotEmpty ? nama.text : modelFetchDetailDosen!.namaDosen;
    if (imageFile == null) {
      modelEditDosen = await service.editDosenTanpaFoto(
        nip: nipDosen,
        nama: namaDosen,
        idDosen: id,
      );
    } else {
      modelEditDosen = await service.editDosen(
        nip: nipDosen,
        nama: namaDosen,
        foto: imageFile!,
        idDosen: id,
      );
    }
    // modelEditDosen = await service.editDosen(
    //   nip: nipDosen,
    //   nama: namaDosen,
    //   foto: imageFile!,
    //   idDosen: id,
    // );
    notifyListeners();
  }
}
