// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_admin_perwalian_if/model/model_login.dart';
import 'package:flutter_admin_perwalian_if/screen/view/login/login.dart';
import 'package:flutter_admin_perwalian_if/services/service_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../view/dosen/home_dosen/home_dosen.dart';
import '../view/home/home.dart';
import '../view/update_data_mahasiswa/update_data_mahasiswa.dart';

class ViewModelLogin with ChangeNotifier {
  final service = LoginService();
  ModelLogin? modelLogin;
  final formKey = GlobalKey<FormState>();
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool isPasswordVisible = false;
  bool isSuksesLogin = false;
  late bool newUser;
  late SharedPreferences logindata;
  String usernameAdminSharedPreference = '';

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

  Future login() async {
    try {
      modelLogin = await service.login(
        username: username.text,
        password: password.text,
      );
      isSuksesLogin = true;
      if (modelLogin!.data.role == "admin") {}
    } catch (e) {
      isSuksesLogin = false;
    }
    notifyListeners();
  }

  void checkLogin(BuildContext context) async {
    logindata = await SharedPreferences.getInstance();
    newUser = logindata.getBool('login') ?? true;

    if (newUser == false) {
      String? role = logindata.getString('role');
      if (role == "admin") {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => Home(
              username: logindata.getString('username_admin') ?? '',
            ),
          ),
          (route) => false,
        );
      } else if (role == "mahasiswa") {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => UpdateDataMahasiswa(
              id: logindata.getInt('id_mahasiswa') ?? 0,
            ),
          ),
          (route) => false,
        );
      } else if (role == "dosen") {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => HomeDosen(
              id: logindata.getInt('id_dosen') ?? 0,
              username: logindata.getString('username_dosen') ?? '',
              fotoDosen: logindata.getString('foto_dosen') ?? '',
            ),
          ),
          (route) => false,
        );
      }
    } else {
      Future.delayed(
        const Duration(seconds: 3),
        () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (_) => const Login(),
            ),
            (route) => false,
          );
        },
      );
    }
  }

  Future<void> saveDataSharedAdmin() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      'username_admin',
      modelLogin!.data.username,
    );
    await prefs.setString(
      'role',
      modelLogin!.data.role,
    );
    notifyListeners();
  }

  Future<void> saveDataSharedMhs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(
      'id_mahasiswa',
      modelLogin!.data.idMahasiswa,
    );

    await prefs.setString(
      'role',
      modelLogin!.data.role,
    );
    notifyListeners();
  }

  Future<void> saveDataSharedDosen() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(
      'id_dosen',
      modelLogin!.data.idDosen,
    );
    await prefs.setString(
      'username_dosen',
      modelLogin!.data.namaDosen,
    );
    await prefs.setString(
      'foto_dosen',
      modelLogin!.data.fotoDosen,
    );
    await prefs.setString(
      'role',
      modelLogin!.data.role,
    );
    notifyListeners();
  }

  Future<void> clearSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await logindata.setBool('login', true);
    await prefs.remove('username_admin');
    await prefs.remove('id_mahasiswa');
    await prefs.remove('id_dosen');
    await prefs.remove('username_dosen');
    await prefs.remove('foto_dosen');
    await prefs.remove('role');
    notifyListeners();
  }
}
