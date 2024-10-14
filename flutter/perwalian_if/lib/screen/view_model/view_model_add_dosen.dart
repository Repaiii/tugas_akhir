import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_admin_perwalian_if/model/model_add_pengguna.dart';
import 'package:image_picker/image_picker.dart';

import '../../model/model_add_dosen.dart';
import '../../services/service_admin.dart';

class ViewModelAddDosen with ChangeNotifier {
  final service = AdminService();
  ModelAddDosen? modelAddDosen;
  ModelAddPengguna? modelAddPengguna;
  final formKey = GlobalKey<FormState>();
  final TextEditingController nama = TextEditingController();
  final TextEditingController nip = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool isPasswordVisible = false;
  File? imageFile;
  String? imagePath;
  bool fotoLebihLimaMB = false;

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

  Future addDosen() async {
    modelAddDosen = await service.addDosen(
      nip: nip.text,
      nama: nama.text,
      foto: imageFile!,
    );
    notifyListeners();
  }

  Future addDosenKePengguna() async {
    modelAddPengguna = await service.addDosenPengguna(
      idPengguna: modelAddDosen!.idPengguna,
      nip: nip.text,
      password: password.text,
    );
    notifyListeners();
  }
}
