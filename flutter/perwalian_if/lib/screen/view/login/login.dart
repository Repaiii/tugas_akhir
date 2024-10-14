// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_admin_perwalian_if/screen/view/dosen/home_dosen/home_dosen.dart';
import 'package:flutter_admin_perwalian_if/screen/view/home/home.dart';
import 'package:flutter_admin_perwalian_if/screen/view/login/widget/text_field_login.dart';
import 'package:flutter_admin_perwalian_if/screen/view/update_data_mahasiswa/update_data_mahasiswa.dart';
import 'package:flutter_admin_perwalian_if/screen/view_model/view_model_login.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

import 'widget/alert.dart';
import 'widget/button_login.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late ViewModelLogin viewModel;
  @override
  void initState() {
    viewModel = Provider.of<ViewModelLogin>(context, listen: false);
    viewModel.isPasswordVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 140,
                ),
                Center(
                  child: Image.asset(
                    "assets/onBoarding.png",
                    width: 120.0,
                    height: 120.0,
                    fit: BoxFit.fill,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Consumer<ViewModelLogin>(
                  builder: (context, model, child) {
                    return Form(
                      key: viewModel.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Username",
                            style: GoogleFonts.poppins(),
                          ),
                          textFieldLogin(
                            controller: viewModel.username,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(13.0),
                              child: SvgPicture.asset(
                                "assets/username.svg",
                              ),
                            ),
                            labelText: "Masukkan username anda disini",
                            validator: (value) =>
                                viewModel.validateUsername(value!),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Kata sandi',
                            style: GoogleFonts.poppins(),
                          ),
                          textFieldLogin(
                            controller: viewModel.password,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(13.0),
                              child: SvgPicture.asset(
                                "assets/lock_kata_sandi.svg",
                              ),
                            ),
                            labelText: "Masukkan kata sandi anda disini",
                            obscureText: !viewModel.isPasswordVisible,
                            sufixIcon: IconButton(
                              icon: Icon(
                                viewModel.isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: const Color(0xFFBDB7B6),
                              ),
                              onPressed: () {
                                viewModel.togglePasswordVisibility();
                              },
                            ),
                            validator: (value) =>
                                viewModel.validatePassword(value!),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          buttonLogin(
                            text: "Masuk",
                            bgColor: const Color(0xFF0067AC),
                            onPressed: () async {
                              await viewModel.login();
                              if (viewModel.isSuksesLogin == true) {
                                if (viewModel.modelLogin!.data.role ==
                                    "admin") {
                                  await viewModel.saveDataSharedAdmin();
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Home(
                                        username:
                                            viewModel.modelLogin!.data.username,
                                      ),
                                    ),
                                    (route) => false,
                                  );
                                } else if (viewModel.modelLogin!.data.role ==
                                    "mahasiswa") {
                                  await viewModel.saveDataSharedMhs();
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UpdateDataMahasiswa(
                                        id: viewModel
                                            .modelLogin!.data.idMahasiswa,
                                      ),
                                    ),
                                    (route) => false,
                                  );
                                } else if (viewModel.modelLogin!.data.role ==
                                    "dosen") {
                                  await viewModel.saveDataSharedDosen();
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HomeDosen(
                                        id: viewModel.modelLogin!.data.idDosen,
                                        username: viewModel
                                            .modelLogin!.data.namaDosen,
                                        fotoDosen: viewModel
                                                .modelLogin?.data.fotoDosen ??
                                            "",
                                      ),
                                    ),
                                    (route) => false,
                                  );
                                }
                                viewModel.logindata.setBool('login', false);

                                viewModel.username.clear();
                                viewModel.password.clear();
                                viewModel.isSuksesLogin = false;
                              } else {
                                customAlert(
                                  context: context,
                                  alertType: QuickAlertType.error,
                                  text:
                                      'Gagal login mohon periksa username atau kata sandi anda',
                                );
                                viewModel.username.clear();
                                viewModel.password.clear();
                              }
                              // }
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
