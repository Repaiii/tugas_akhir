// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_admin_perwalian_if/screen/view/dosen/home_dosen/detail_mahasiswa.dart';
import 'package:flutter_admin_perwalian_if/screen/view/home/widget/button_card.dart';
import 'package:flutter_admin_perwalian_if/screen/view_model/view_model_dosen.dart';
import 'package:flutter_admin_perwalian_if/screen/view_model/view_model_login.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../login/login.dart';

class HomeDosen extends StatefulWidget {
  final int id;
  final String username;
  final String fotoDosen;
  const HomeDosen({
    Key? key,
    required this.id,
    required this.username,
    required this.fotoDosen,
  }) : super(key: key);

  @override
  State<HomeDosen> createState() => _HomeDosenState();
}

class _HomeDosenState extends State<HomeDosen> {
  late ViewModelDosen viewModel;
  late ViewModelLogin viewModelLogin;
  @override
  void initState() {
    viewModel = Provider.of<ViewModelDosen>(context, listen: false);
    viewModelLogin = Provider.of<ViewModelLogin>(context, listen: false);
    viewModel.fetchDetailDosen(
      id: widget.id,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: SizedBox(
          height: 150.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(
                            widget.fotoDosen,
                          ),
                        ),
                        const SizedBox(width: 7),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Selamat Datang',
                              style: GoogleFonts.poppins(
                                color: const Color(0xFFBDB7B6),
                                fontSize: 11,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Text(
                              widget.username,
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
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const Login(),
                                      ),
                                      (route) => false,
                                    );
                                    viewModelLogin.clearSharedPreferences();
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
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
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
              ),
              const Divider(thickness: 1.5,)
            ],
          ),
        ),
        toolbarHeight: 70,
      ),
      body: Consumer<ViewModelDosen>(
        builder: (context, model, child) {
          double? lowestIps = viewModel.getLowestIps();
          double? highestIps = viewModel.getHighestIps();
          double? lowestIpk = viewModel.getLowestIpk();
          double? highestIpk = viewModel.getHighestIpk();
          int? lowestSkpm = viewModel.getLowestSkpm();
          int? highestSkpm = viewModel.getHighestSkpm();
          int? lowestSemester = viewModel.getLowestSemester();
          int? highestSemester = viewModel.getHighestSemester();
          int totalMahasiswa = viewModel.getTotalMahasiswa();
          int totalMahasiswaBahaya = viewModel.getTotalMahasiswaBahaya();
          int totalMahasiswaCukup = viewModel.getTotalMahasiswaCukup();
          int totalMahasiswaAman = viewModel.getTotalMahasiswaAman();
          return viewModel.isLoading
              ? RefreshIndicator(
                  onRefresh: () async {
                    await viewModel.fetchDetailDosen(
                      id: widget.id,
                    );
                  },
                  child: SafeArea(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Container(
                              height: MediaQuery.of(context).size.height / 4.7,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: const Color(0xFF0067AC),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 30,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 12.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '',
                                            style: GoogleFonts.poppins(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            'IPS',
                                            style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            'IPK',
                                            style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            'SK2PM',
                                            style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            'Semester',
                                            style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(top: 10),
                                          child: Column(
                                            children: [
                                              Text(
                                                'Terendah',
                                                style: GoogleFonts.poppins(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                lowestIps != null
                                                    ? lowestIps.toStringAsFixed(2)
                                                    : 'N/A',
                                                style: GoogleFonts.poppins(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                lowestIpk != null
                                                    ? lowestIpk.toStringAsFixed(2)
                                                    : 'N/A',
                                                style: GoogleFonts.poppins(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                lowestSkpm != null
                                                    ? lowestSkpm
                                                        .toStringAsFixed(0)
                                                    : 'N/A',
                                                style: GoogleFonts.poppins(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                lowestSemester != null
                                                    ? lowestSemester
                                                        .toStringAsFixed(0)
                                                    : 'N/A',
                                                style: GoogleFonts.poppins(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 10.0),
                                          child: Column(
                                            children: [
                                              Text(
                                                'Tertinggi',
                                                style: GoogleFonts.poppins(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                highestIps != null
                                                    ? highestIps
                                                        .toStringAsFixed(2)
                                                    : 'N/A',
                                                style: GoogleFonts.poppins(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                highestIpk != null
                                                    ? highestIpk
                                                        .toStringAsFixed(2)
                                                    : 'N/A',
                                                style: GoogleFonts.poppins(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                highestSkpm != null
                                                    ? highestSkpm
                                                        .toStringAsFixed(0)
                                                    : 'N/A',
                                                style: GoogleFonts.poppins(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                highestSemester != null
                                                    ? highestSemester
                                                        .toStringAsFixed(0)
                                                    : 'N/A',
                                                style: GoogleFonts.poppins(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
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
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 20),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            height:
                                                MediaQuery.of(context).size.height /
                                                    12,
                                            width:
                                                MediaQuery.of(context).size.width /
                                                    2,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: const Color(0xFFFDFFA2),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 14.0),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    'Mahasiswa Cukup',
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 13.5,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                  Text(
                                                    "$totalMahasiswaCukup",
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 24,
                                                      fontWeight: FontWeight.w700,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height:
                                                MediaQuery.of(context).size.height /
                                                    80,
                                          ),
                                          Container(
                                            height:
                                                MediaQuery.of(context).size.height /
                                                    12,
                                            width:
                                                MediaQuery.of(context).size.width /
                                                    2,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: const Color(0xFFEA8585),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 14.0),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    'Mahasiswa Bahaya',
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 13.5,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                  Text('$totalMahasiswaBahaya',
                                                      style: GoogleFonts.poppins(
                                                        fontSize: 24,
                                                        fontWeight: FontWeight.w700,
                                                      ))
                                                ],
                                              ),
                                            ),
                                          ),
                                        ]),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width / 15,
                                    ),
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height / 5.7,
                                      width: MediaQuery.of(context).size.width / 3,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: const Color(0xFF86C684),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "$totalMahasiswaAman",
                                              style: GoogleFonts.poppins(
                                                fontSize: 35,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              'Mahasiswa',
                                              style: GoogleFonts.poppins(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              'Aman',
                                              style: GoogleFonts.poppins(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Divider(thickness: 1.5,),
                          ),
                          const SizedBox(height: 10,),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16, right: 16, bottom: 16,),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Mahasiswa Perwalian ($totalMahasiswa)',
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Center(
                              child: Wrap(
                                spacing: 10.0,
                                runSpacing: 10.0,
                                children: List.generate(
                                  viewModel.modelFetchDetailDosen!
                                      .mahasiswaPerwalian.length,
                                  (index) {
                                    final dataMhs = viewModel
                                        .modelFetchDetailDosen!
                                        .mahasiswaPerwalian[index];
                                    if (dataMhs == null) {
                                      return Container();
                                    } else {
                                      return Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.3,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                3.15,
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
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    child: Image.network(
                                                      dataMhs.fotoMahasiswa,
                                                      width: double.infinity,
                                                      height: 120.0,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    dataMhs.nama,
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  Text(
                                                    dataMhs.nim,
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w200,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Container(
                                                    height: 25,
                                                    width: 70,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: viewModel
                                                            .getStatusColor(
                                                          dataMhs.status,
                                                        ),
                                                      ),
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                        Radius.circular(3.0),
                                                      ),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        dataMhs.status,
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color: viewModel
                                                              .getStatusColor(
                                                            dataMhs.status,
                                                          ),
                                                          fontSize: 12.5,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              buttonCard(
                                                text: "Lihat",
                                                bgColor:
                                                    const Color(0xFF0067AC),
                                                onPressed: () async {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          DetailMahasiswa(
                                                        id: dataMhs.idMahasiswa,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ),
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
