// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_admin_perwalian_if/screen/view/login/login.dart';
import 'package:flutter_admin_perwalian_if/screen/view_model/view_model_login.dart';
import 'package:flutter_admin_perwalian_if/screen/view_model/view_model_update_data_mahasiswa.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';
import '../login/widget/alert.dart';
import 'widget/button_update_mahasiswa.dart';
import 'widget/text_field_update_mahasiswa.dart';

class UpdateDataMahasiswa extends StatefulWidget {
  final int id;
  const UpdateDataMahasiswa({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<UpdateDataMahasiswa> createState() => _UpdateDataMahasiswaState();
}

class _UpdateDataMahasiswaState extends State<UpdateDataMahasiswa> {
  late ViewModelUpdateDataMahasiswa viewModel;
  late ViewModelLogin viewModelLogin;
  @override
  void initState() {
    viewModel =
        Provider.of<ViewModelUpdateDataMahasiswa>(context, listen: false);
    viewModelLogin = Provider.of<ViewModelLogin>(context, listen: false);
    viewModel.fetchMahasiswa(
      id: widget.id,
    );
    //viewModel.clearAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ViewModelUpdateDataMahasiswa>(
        builder: (context, model, child) {
          return viewModel.isLoading
              ? SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 85.0,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 20,
                                          backgroundImage: NetworkImage(
                                            viewModel.modelFetchMahasiswa
                                                    ?.fotoMahasiswa ??
                                                "https://drive.usercontent.google.com/download?id=15IGk-GXk1Zf0yyXlx1TUSMlrYLue9_Y0&export=view",
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Selamat Datang',
                                              style: GoogleFonts.poppins(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                            Text(
                                              viewModel
                                                  .modelFetchMahasiswa!.nama,
                                              style: GoogleFonts.poppins(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text("Peringatan"),
                                              content: const Text(
                                                "Anda Yakin Ingin Keluar?",
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text("Tidak"),
                                                ),
                                                TextButton(
                                                  onPressed: () async {
                                                    Navigator
                                                        .pushAndRemoveUntil(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            const Login(),
                                                      ),
                                                      (route) => false,
                                                    );
                                                    viewModelLogin
                                                        .clearSharedPreferences();
                                                  },
                                                  child: const Text("Ya"),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      child: Container(
                                        height: 35,
                                        width: 35,
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(
                                              6.0,
                                            ),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: SvgPicture.asset(
                                            "assets/button_logout.svg",
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider(
                                  thickness: 1.5,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5,),
                          Text(
                            'Perbarui Data',
                            style: GoogleFonts.poppins(
                              fontSize: 23,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Consumer<ViewModelUpdateDataMahasiswa>(
                            builder: (context, model, child) {
                              return Form(
                                key: viewModel.formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Indeks Penilaian Semester",
                                      style: GoogleFonts.poppins(
                                        fontSize: 15.5,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    textFieldUpdateMahasiswa(
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                          RegExp(r'^(\d+)?\.?\d{0,2}'),
                                        ),
                                      ],
                                      keyboardType: TextInputType.phone,
                                      controller: viewModel.ips,
                                      labelText:
                                          "${viewModel.modelFetchMahasiswa!.ips}",
                                      validator: (value) =>
                                          viewModel.validateIps(value!),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Indeks Penilaian Kumulatif",
                                      style: GoogleFonts.poppins(
                                        fontSize: 15.5,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    textFieldUpdateMahasiswa(
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                          RegExp(r'^(\d+)?\.?\d{0,2}'),
                                        ),
                                      ],
                                      keyboardType: TextInputType.phone,
                                      controller: viewModel.ipk,
                                      labelText:
                                          "${viewModel.modelFetchMahasiswa!.ipk}",
                                      validator: (value) =>
                                          viewModel.validateIpk(value!),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "SK2PM",
                                      style: GoogleFonts.poppins(
                                        fontSize: 15.5,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    textFieldUpdateMahasiswa(
                                      keyboardType: TextInputType.phone,
                                      controller: viewModel.skpm,
                                      labelText:
                                          "${viewModel.modelFetchMahasiswa!.sk2Pm}",
                                    ),
                                    const SizedBox(
                                      height: 50,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        buttonUpdateMahasiswa(
                                          text: 'Reset',
                                          bgColor: const Color(0xFFFEFEFE),
                                          textColor: const Color(0xFF0067AC),
                                          onPressed: () {
                                            viewModel.clearAll();
                                          },
                                          borderColor: const Color(0xFF0067AC),
                                        ),
                                        buttonUpdateMahasiswa(
                                          text: 'Simpan',
                                          bgColor: const Color(0xFF0067AC),
                                          textColor: const Color(0xFFFBFBFB),
                                          borderColor: const Color(0xFF0067AC),
                                          onPressed: () async {
                                            if (viewModel.ips.text.isNotEmpty ||
                                                viewModel.ipk.text.isNotEmpty ||
                                                viewModel
                                                    .skpm.text.isNotEmpty) {
                                              if (viewModel
                                                  .formKey.currentState!
                                                  .validate()) {
                                                await viewModel
                                                    .updateDataMahasiswa(
                                                  id: widget.id,
                                                );
                                                customAlert(
                                                  context: context,
                                                  alertType:
                                                      QuickAlertType.success,
                                                  text:
                                                      'Berhasil memperbarui data',
                                                );
                                              }
                                            } else {
                                              customAlert(
                                                context: context,
                                                alertType: QuickAlertType.error,
                                                text:
                                                    'Anda tidak mengubah apapun, Mohon isi terlebih dahulu',
                                              );
                                            }
                                          },
                                        ),
                                      ],
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
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}
