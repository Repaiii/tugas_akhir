// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_admin_perwalian_if/screen/view_model/view_model_dosen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DetailMahasiswa extends StatefulWidget {
  final int id;
  const DetailMahasiswa({Key? key, required this.id}) : super(key: key);

  @override
  State<DetailMahasiswa> createState() => _DetailMahasiswaState();
}

class _DetailMahasiswaState extends State<DetailMahasiswa> {
  late ViewModelDosen viewModel;
  @override
  void initState() {
    viewModel = Provider.of<ViewModelDosen>(context, listen: false);
    viewModel.fetchMahasiswaById(
      id: widget.id,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Detail Mahasiswa",
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
        actions: const [],
      ),
      body: Consumer<ViewModelDosen>(
        builder: (context, model, child) {
          return viewModel.isLoadingDetailMhs
              ? RefreshIndicator(
                  onRefresh: () async {
                    await viewModel.fetchMahasiswaById(
                      id: widget.id,
                    );
                  },
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            children: [
                              Container(
                                height: 200.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      viewModel.modelFetchMahasiswaById!
                                          .fotoMahasiswa,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    height: 70.0,
                                    width: double.infinity,
                                    decoration: const BoxDecoration(
                                      color:
                                          Color.fromRGBO(104, 104, 104, 0.543),
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(8.0),
                                        bottomRight: Radius.circular(8.0),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                viewModel
                                                    .modelFetchMahasiswaById!
                                                    .nama,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 14,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Text(
                                                viewModel
                                                    .modelFetchMahasiswaById!
                                                    .nim,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w300,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 200.0,
                                    width: 180,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Prodi',
                                          style: GoogleFonts.poppins(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xFF0067AC),
                                          ),
                                        ),
                                        Text(
                                          'Informatika',
                                          style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          'IP Semester',
                                          style: GoogleFonts.poppins(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xFF0067AC),
                                          ),
                                        ),
                                        Text(
                                          '${viewModel.modelFetchMahasiswaById!.ips}',
                                          style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          'SK2PM',
                                          style: GoogleFonts.poppins(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xFF0067AC),
                                          ),
                                        ),
                                        Text(
                                          '${viewModel.modelFetchMahasiswaById!.sk2Pm}',
                                          style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 200.0,
                                    width: 165,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Semester',
                                          style: GoogleFonts.poppins(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xFF0067AC),
                                          ),
                                        ),
                                        Text(
                                          '${viewModel.modelFetchMahasiswaById!.semester}',
                                          style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          'IP Komulatif',
                                          style: GoogleFonts.poppins(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xFF0067AC),
                                          ),
                                        ),
                                        Text(
                                          '${viewModel.modelFetchMahasiswaById!.ipk}',
                                          style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          'Pembayaran UKT',
                                          style: GoogleFonts.poppins(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xFF0067AC),
                                          ),
                                        ),
                                        Container(
                                          height: 25,
                                          width: 115,
                                          decoration: BoxDecoration(
                                            color: viewModel
                                                        .modelFetchMahasiswaById!
                                                        .pembayaranUkt ==
                                                    'Belum Bayar'
                                                ? Colors.red
                                                : const Color(0xFF1AC50B),
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(
                                                3.0,
                                              ),
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              viewModel.modelFetchMahasiswaById!
                                                  .pembayaranUkt,
                                              style: GoogleFonts.poppins(
                                                color: Colors.white,
                                                fontSize: 12.5,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
