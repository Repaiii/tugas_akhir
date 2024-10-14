// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_admin_perwalian_if/screen/view/dosen/add_dosen/widget/button_add_dosen.dart';
import 'package:flutter_admin_perwalian_if/screen/view_model/view_model_add_dosen.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

import '../../home/home.dart';
import '../../login/widget/alert.dart';
import 'widget/text_field_add_dosen.dart';

class AddDosen extends StatefulWidget {
  final String username;
  const AddDosen({
    Key? key,
    required this.username,
  }) : super(key: key);

  @override
  State<AddDosen> createState() => _AddDosenState();
}

class _AddDosenState extends State<AddDosen> {
  late ViewModelAddDosen viewModel;
  @override
  void initState() {
    viewModel = Provider.of<ViewModelAddDosen>(context, listen: false);
    //viewModel.clearAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Data Dosen",
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Container(
              color: Colors.grey,
              height: 0.5,
            ),
          ),
        ),
        actions: const [],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Consumer<ViewModelAddDosen>(
            builder: (context, model, child) {
              return Form(
                key: viewModel.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Nama Dosen",
                      style: GoogleFonts.poppins(),
                    ),
                    textFieldAddDosen(
                      controller: viewModel.nama,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: SvgPicture.asset(
                          "assets/username.svg",
                        ),
                      ),
                      labelText: "Nama",
                      validator: (value) => viewModel.validateUsername(value!),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "NIP",
                      style: GoogleFonts.poppins(),
                    ),
                    textFieldAddDosen(
                      keyboardType: TextInputType.phone,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      controller: viewModel.nip,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: SvgPicture.asset(
                          "assets/nip.svg",
                        ),
                      ),
                      labelText: "1998996xxx",
                      validator: (value) => viewModel.validateUsername(value!),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Kata Sandi",
                      style: GoogleFonts.poppins(),
                    ),
                    textFieldAddDosen(
                      controller: viewModel.password,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: SvgPicture.asset(
                          "assets/lock_kata_sandi.svg",
                        ),
                      ),
                      labelText: "Kata Sandi",
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
                      validator: (value) => viewModel.validatePassword(value!),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Foto Dosen",
                      style: GoogleFonts.poppins(),
                    ),
                    GestureDetector(
                      onTap: () {
                        viewModel.pickImage();
                      },
                      child: Container(
                        height: 200.0,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xFFBDB7B6),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: viewModel.imageFile != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.file(
                                  viewModel.imageFile!,
                                  width: double.infinity,
                                  height: 200.0,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: SvgPicture.asset(
                                    "assets/select_foto_add_dosen.svg",
                                  ),
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buttonAddDosen(
                          text: 'Reset',
                          bgColor: const Color(0xFFFEFEFE),
                          textColor: const Color(0xFF0067AC),
                          onPressed: () {
                            viewModel.clearAll();
                          },
                          borderColor: const Color(0xFF0067AC),
                        ),
                        buttonAddDosen(
                          text: 'Simpan',
                          bgColor: const Color(0xFF0067AC),
                          textColor: const Color(0xFFFBFBFB),
                          borderColor: const Color(0xFF0067AC),
                          onPressed: () async {
                            try {
                              await viewModel.addDosen();
                              await viewModel.addDosenKePengguna();
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Home(
                                    username: widget.username,
                                  ),
                                ),
                                (route) => false,
                              );
                              viewModel.clearAll();
                            } catch (e) {
                              customAlert(
                                context: context,
                                alertType: QuickAlertType.error,
                                text: 'Pastikan anda telah mengisi semua data',
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
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: buttonAddDosen(
      //         text: 'Reset',
      //         bgColor: const Color(0xFFFEFEFE),
      //         textColor: const Color(0xFF0067AC),
      //         onPressed: () {},
      //         borderColor: const Color(0xFF0067AC),
      //       ),
      //       label: '',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: buttonAddDosen(
      //         text: 'Simpan',
      //         bgColor: const Color(0xFF0067AC),
      //         textColor: const Color(0xFFFBFBFB),
      //         borderColor: const Color(0xFF0067AC),
      //         onPressed: () {},
      //       ),
      //       label: '',
      //     ),
      //   ],
      // ),
    );
  }
}
