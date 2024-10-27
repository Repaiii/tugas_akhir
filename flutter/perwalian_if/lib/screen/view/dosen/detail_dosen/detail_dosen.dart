// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_admin_perwalian_if/screen/view/add_mahasiswa/add_mahasiswa.dart';
import 'package:flutter_admin_perwalian_if/screen/view/dosen/detail_dosen/edit_data_dosen.dart';
import 'package:flutter_admin_perwalian_if/screen/view/dosen/detail_dosen/widget/button_delete_card.dart';
import 'package:flutter_admin_perwalian_if/screen/view/home/home.dart';
import 'package:flutter_admin_perwalian_if/screen/view_model/view_model_home.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'widget/button_detail_dosen.dart';

class DetailDosen extends StatefulWidget {
  final int id;
  final String username;
  const DetailDosen({
    Key? key,
    required this.id,
    required this.username,
  }) : super(key: key);

  @override
  State<DetailDosen> createState() => _DetailDosenState();
}

class _DetailDosenState extends State<DetailDosen> {
  late ViewModelHome viewModelHome;
  @override
  void initState() {
    viewModelHome = Provider.of<ViewModelHome>(context, listen: false);
    viewModelHome.fetchDetailDosen(
      id: widget.id,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Detail Dosen",
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
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
                builder: (context) => Home(
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
        actions: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditDosen(
                      id: widget.id,
                      username: widget.username,
                    ),
                  ),
                );
              },
              child: SvgPicture.asset(
                "assets/button_edit_detail_dosen.svg",
              ),
            ),
          ),
        ],
      ),
      body: Consumer<ViewModelHome>(
        builder: (context, model, child) {
          return viewModelHome.isLoadingDetail
              ? RefreshIndicator(
                  onRefresh: () async {
                    await viewModelHome.fetchDetailDosen(
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
                                height: 250.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      viewModelHome
                                          .modelFetchDetailDosen!.fotoDosen,
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
                                                viewModelHome
                                                    .modelFetchDetailDosen!
                                                    .namaDosen,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 14,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Text(
                                                viewModelHome
                                                    .modelFetchDetailDosen!.nip,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w300,
                                                ),
                                              ),
                                            ],
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: const Text(
                                                        "Peringatan"),
                                                    content: Text(
                                                      "Anda Yakin Ingin Menghapus ${viewModelHome.modelFetchDetailDosen!.namaDosen} Sebagai Dosen?",
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child:
                                                            const Text("Tidak"),
                                                      ),
                                                      TextButton(
                                                        onPressed: () async {
                                                          await viewModelHome
                                                              .deleteDosen(
                                                            idDosen: widget.id,
                                                          );

                                                          Navigator
                                                              .pushAndRemoveUntil(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      Home(
                                                                username: widget
                                                                    .username,
                                                              ),
                                                            ),
                                                            (route) => false,
                                                          );
                                                        },
                                                        child: const Text("Ya"),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            icon: const Icon(
                                              Icons.delete,
                                              size: 24.0,
                                              color: Colors.white,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Divider(
                                thickness: 1.5,
                              ),
                              if (viewModelHome.modelFetchDetailDosen!
                                      .mahasiswaPerwalian.length ==
                                  1)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          2.25,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              10,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFEFEFE),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.2),
                                            spreadRadius: 0.5,
                                            blurRadius: 1.0,
                                            offset: const Offset(0, 1),
                                          ),
                                        ],
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                5,
                                              ),
                                              child: Image.network(
                                                viewModelHome
                                                    .modelFetchDetailDosen!
                                                    .mahasiswaPerwalian
                                                    .first
                                                    .fotoMahasiswa,
                                                width: 75,
                                                height: 75,
                                                fit: BoxFit.cover,
                                                errorBuilder: (BuildContext
                                                        context,
                                                    Object exception,
                                                    StackTrace? stackTrace) {
                                                  return const Center(
                                                    child: Icon(
                                                      Icons
                                                          .person, // Ikon yang ditampilkan saat gambar gagal dimuat
                                                      size: 75.0,
                                                      color: Colors.grey,
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  viewModelHome.truncateText(
                                                    viewModelHome
                                                        .modelFetchDetailDosen!
                                                        .mahasiswaPerwalian
                                                        .first
                                                        .nama,
                                                  ),
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                Text(
                                                  viewModelHome
                                                      .modelFetchDetailDosen!
                                                      .mahasiswaPerwalian
                                                      .first
                                                      .nim,
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w200,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                buttonDeleteMahasiswa(
                                                  fontSize: 10,
                                                  bgColor: Colors.white,
                                                  textColor:
                                                      const Color(0xFFC50B0B),
                                                  borderColor:
                                                      const Color(0xFFC50B0B),
                                                  onPressed: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          title: const Text(
                                                              "Peringatan"),
                                                          content: Text(
                                                            "Anda Yakin Ingin Menghapus ${viewModelHome.modelFetchDetailDosen!.mahasiswaPerwalian.first.nama}?",
                                                          ),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              child: const Text(
                                                                "Tidak",
                                                              ),
                                                            ),
                                                            TextButton(
                                                              onPressed:
                                                                  () async {
                                                                await viewModelHome
                                                                    .deleteMahasiswaDiDosen(
                                                                  idDosen: viewModelHome
                                                                      .modelFetchDetailDosen!
                                                                      .idDosen,
                                                                  idMhs: viewModelHome
                                                                      .modelFetchDetailDosen!
                                                                      .mahasiswaPerwalian
                                                                      .first
                                                                      .idMahasiswa,
                                                                );
                                                                await viewModelHome
                                                                    .fetchDetailDosen(
                                                                  id: widget.id,
                                                                );
                                                                Navigator.of(
                                                                  context,
                                                                ).pop();
                                                              },
                                                              child: const Text(
                                                                  "Ya"),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              else
                                // SliverList(
                                //   delegate: SliverChildListDelegate(
                                //     [
                                //       Padding(
                                //         padding: const EdgeInsets.symmetric(
                                //             horizontal: 12.0, vertical: 6.0),
                                //         child: Column(
                                //           children: [
                                //             if (viewModelHome
                                //                     .modelFetchDetailDosen!
                                //                     .mahasiswaPerwalian
                                //                     .length ==
                                //                 1)
                                //               Align(
                                //                 alignment: Alignment.centerLeft,
                                //                 child: MahasiswaCard(
                                //                   data: viewModelHome
                                //                       .modelFetchDetailDosen!
                                //                       .mahasiswaPerwalian
                                //                       .first,
                                //                   onDelete: () {
                                //                     DeleteConfirmationDialog(
                                //                       context,
                                //                       nama: viewModelHome
                                //                           .modelFetchDetailDosen!
                                //                           .mahasiswaPerwalian
                                //                           .first
                                //                           .nama,
                                //                       idDosen: widget.id,
                                //                       idMahasiswa: viewModelHome
                                //                           .modelFetchDetailDosen!
                                //                           .mahasiswaPerwalian
                                //                           .first
                                //                           .idMahasiswa,
                                //                     );
                                //                   },
                                //                 ),
                                //               )
                                //             else
                                //               Wrap(
                                //                 spacing: 10.0,
                                //                 runSpacing: 10.0,
                                //                 children: List.generate(
                                //                   viewModelHome
                                //                       .modelFetchDetailDosen!
                                //                       .mahasiswaPerwalian
                                //                       .length,
                                //                   (index) {
                                //                     final data = viewModelHome
                                //                         .modelFetchDetailDosen!
                                //                         .mahasiswaPerwalian[index];
                                //                     return MahasiswaCard(
                                //                       data: data,
                                //                       onDelete: () {
                                //                         DeleteConfirmationDialog(
                                //                           context,
                                //                           nama: data.nama,
                                //                           idDosen: widget.id,
                                //                           idMahasiswa:
                                //                               data.idMahasiswa,
                                //                         );
                                //                       },
                                //                     );
                                //                   },
                                //                 ),
                                //               ),
                                //           ],
                                //         ),
                                //       ),
                                //     ],
                                //   ),
                                // ),
                                Wrap(
                                  spacing: 10.0,
                                  runSpacing: 10.0,
                                  children: List.generate(
                                    viewModelHome.modelFetchDetailDosen!
                                        .mahasiswaPerwalian.length,
                                    (index) {
                                      final data = viewModelHome
                                          .modelFetchDetailDosen!
                                          .mahasiswaPerwalian[index];
                                      return Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.25,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                10,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFFEFEFE),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.2),
                                              spreadRadius: 0.5,
                                              blurRadius: 1.0,
                                              offset: const Offset(0, 1),
                                            ),
                                          ],
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  5,
                                                ),
                                                child: Image.network(
                                                  data.fotoMahasiswa,
                                                  width: 75,
                                                  height: 75,
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (BuildContext
                                                          context,
                                                      Object exception,
                                                      StackTrace? stackTrace) {
                                                    return const Center(
                                                      child: Icon(
                                                        Icons
                                                            .person, // Ikon yang ditampilkan saat gambar gagal dimuat
                                                        size: 75.0,
                                                        color: Colors.grey,
                                                      ),
                                                    );
                                                  },
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
                                                    viewModelHome.truncateText(
                                                        data.nama),
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  Text(
                                                    data.nim,
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.w200,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  buttonDeleteMahasiswa(
                                                    fontSize: 10,
                                                    bgColor: Colors.white,
                                                    textColor:
                                                        const Color(0xFFC50B0B),
                                                    borderColor:
                                                        const Color(0xFFC50B0B),
                                                    onPressed: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return AlertDialog(
                                                            title: const Text(
                                                                "Peringatan"),
                                                            content: Text(
                                                              "Anda Yakin Ingin Menghapus ${data.nama}?",
                                                            ),
                                                            actions: [
                                                              TextButton(
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                                child:
                                                                    const Text(
                                                                  "Tidak",
                                                                ),
                                                              ),
                                                              TextButton(
                                                                onPressed:
                                                                    () async {
                                                                  await viewModelHome
                                                                      .deleteMahasiswaDiDosen(
                                                                    idDosen: viewModelHome
                                                                        .modelFetchDetailDosen!
                                                                        .idDosen,
                                                                    idMhs: data
                                                                        .idMahasiswa,
                                                                  );
                                                                  await viewModelHome
                                                                      .fetchDetailDosen(
                                                                    id: widget
                                                                        .id,
                                                                  );
                                                                  Navigator.of(
                                                                    context,
                                                                  ).pop();
                                                                },
                                                                child:
                                                                    const Text(
                                                                        "Ya"),
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      );
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
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
      persistentFooterButtons: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
          ),
          child: buttonDetailDosen(
            text: '+ Tambah Mahasiswa',
            widthButton: double.infinity,
            fontSize: 16,
            bgColor: const Color(0xFF0067AC),
            textColor: const Color(0xFFFBFBFB),
            borderColor: const Color(0xFF0067AC),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddMahasiswa(
                    id: viewModelHome.modelFetchDetailDosen!.idDosen,
                    username: widget.username,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
