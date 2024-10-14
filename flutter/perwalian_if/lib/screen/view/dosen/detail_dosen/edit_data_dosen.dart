// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_admin_perwalian_if/screen/view_model/view_model_edit_dosen.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';
import '../../home/home.dart';
import '../../login/widget/alert.dart';
import '../add_dosen/widget/button_add_dosen.dart';
import '../add_dosen/widget/text_field_add_dosen.dart';

class EditDosen extends StatefulWidget {
  final int id;
  final String username;
  const EditDosen({
    Key? key,
    required this.id,
    required this.username,
  }) : super(key: key);

  @override
  State<EditDosen> createState() => _EditDosenState();
}

class _EditDosenState extends State<EditDosen> {
  late ViewModelEditDosen viewModel;
  @override
  void initState() {
    viewModel = Provider.of<ViewModelEditDosen>(context, listen: false);
    viewModel.fetchDetailDosen(
      id: widget.id,
    );
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
            fontSize: 18,
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
      body: Consumer<ViewModelEditDosen>(
        builder: (context, model, child) {
          return viewModel.isLoading
              ? SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Form(
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
                              labelText:
                                  viewModel.modelFetchDetailDosen!.namaDosen,
                              validator: (value) =>
                                  viewModel.validateUsername(value!),
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
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              controller: viewModel.nip,
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(13.0),
                                child: SvgPicture.asset(
                                  "assets/nip.svg",
                                ),
                              ),
                              labelText: viewModel.modelFetchDetailDosen!.nip,
                              validator: (value) =>
                                  viewModel.validateUsername(value!),
                            ),
                            const SizedBox(
                              height: 10,
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
                                        borderRadius:
                                            BorderRadius.circular(8.0),
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
                                          child: Image.network(
                                            viewModel.modelFetchDetailDosen!
                                                .fotoDosen,
                                            width: double.infinity,
                                            height: 200.0,
                                            fit: BoxFit.cover,
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
                                    if (viewModel.nama.text.isNotEmpty ||
                                        viewModel.nip.text.isNotEmpty ||
                                        viewModel.imageFile != null) {
                                      await viewModel.editDosen(
                                        id: widget.id,
                                      );
                                      await viewModel.fetchDetailDosen(
                                        id: widget.id,
                                      );
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
                      )),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}
