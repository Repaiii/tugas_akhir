import 'package:flutter/material.dart';
import 'package:flutter_admin_perwalian_if/screen/view/dosen/detail_dosen/detail_dosen.dart';
import 'package:flutter_admin_perwalian_if/screen/view_model/view_model_home.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../dosen/detail_dosen/widget/button_detail_dosen.dart';

class AddMahasiswa extends StatefulWidget {
  final int id;
  final String username;
  const AddMahasiswa({
    Key? key,
    required this.id,
    required this.username,
  }) : super(key: key);

  @override
  State<AddMahasiswa> createState() => _AddMahasiswaState();
}

class _AddMahasiswaState extends State<AddMahasiswa> {
  late ViewModelHome viewModel;
  @override
  void initState() {
    viewModel = Provider.of<ViewModelHome>(context, listen: false);
    //viewModel.clearSelection();
    viewModel.fetchMahasiswaNonPerwalian();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tambah Mahasiswa",
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        leading: IconButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => DetailDosen(
                  id: widget.id,
                  username: widget.username,
                ),
              ),
              (route) => false,
            );
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 24.0,
          ),
        ),
        actions: [],
      ),
      body: Consumer<ViewModelHome>(
        builder: (context, model, child) {
          return viewModel.isLoadingNonPerwalian
              ? SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        for (final data in viewModel.modelNonPerwalian!.data)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                      10,
                                    ),
                                    child: Image.network(
                                      data.fotoMahasiswa ?? "",
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                      errorBuilder: (BuildContext context,
                                          Object exception,
                                          StackTrace? stackTrace) {
                                        return const Center(
                                          child: Icon(
                                            Icons
                                                .person, // Ikon yang ditampilkan saat gambar gagal dimuat
                                            size: 50.0,
                                            color: Colors.grey,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data.nama,
                                        style: GoogleFonts.poppins(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        "${data.nim}",
                                        style: GoogleFonts.poppins(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              IconButton(
                                icon: Icon(
                                  model.selectedMahasiswaId
                                          .contains(data.idMahasiswa)
                                      ? Icons.radio_button_checked
                                      : Icons.radio_button_unchecked,
                                  color: model.selectedMahasiswaId
                                          .contains(data.idMahasiswa)
                                      ? const Color(0xFF0067AC)
                                      : Colors.black,
                                ),
                                onPressed: () {
                                  model.toggleSelection(data.idMahasiswa);
                                },
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
      persistentFooterButtons: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
          ),
          child: buttonDetailDosen(
            text: '+ Tambah',
            widthButton: double.infinity,
            fontSize: 16,
            bgColor: const Color(0xFF0067AC),
            textColor: const Color(0xFFFBFBFB),
            borderColor: const Color(0xFF0067AC),
            onPressed: () async {
              await viewModel.addMahasiswaDiDosen(
                idDosen: widget.id,
              );
              await viewModel.fetchMahasiswaNonPerwalian();
              viewModel.clearSelection();
            },
          ),
        ),
      ],
    );
  }
}
