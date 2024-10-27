import 'package:flutter/material.dart';
import 'package:flutter_admin_perwalian_if/screen/view/dosen/add_dosen/add_dosen.dart';
import 'package:flutter_admin_perwalian_if/screen/view/dosen/detail_dosen/detail_dosen.dart';
import 'package:flutter_admin_perwalian_if/screen/view/dosen/home_dosen/detail_mahasiswa.dart';
import 'package:flutter_admin_perwalian_if/screen/view_model/view_model_home.dart';
import 'package:flutter_admin_perwalian_if/screen/view_model/view_model_login.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../login/login.dart';
import 'widget/button_card.dart';

class Home extends StatefulWidget {
  final String username;
  const Home({Key? key, required this.username}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late ViewModelHome viewModel;
  late ViewModelLogin viewModelLogin;
  int _currentIndex = 0;

  @override
  void initState() {
    viewModel = Provider.of<ViewModelHome>(context, listen: false);
    viewModelLogin = Provider.of<ViewModelLogin>(context, listen: false);
    viewModel.fetchAllDosen();
    viewModel.fetchAllMahasiswa();
    super.initState();
  }

  List<Widget> _pages() {
    return [
      dosenPage(),
      mahasiswaPage(),
    ];
  }

  Widget dosenPage() {
    return Consumer<ViewModelHome>(
      builder: (context, model, child) {
        return viewModel.isLoading
            ? RefreshIndicator(
                onRefresh: () async {
                  await viewModel.fetchAllDosen();
                },
                child: SafeArea(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 85.0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const CircleAvatar(
                                        backgroundColor: Colors.white,
                                        child: Icon(
                                          Icons.person,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      const SizedBox(width: 7),
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
                                          Radius.circular(6.0),
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
                      ),
                      Expanded(
                        child: ListView(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: Text(
                                'Dosen Informatika',
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Center(
                              child: Wrap(
                                spacing: 10.0,
                                runSpacing: 10.0,
                                children: List.generate(
                                  viewModel.modelFetchAllDosen!.data.length,
                                  (index) {
                                    final dataDosen = viewModel
                                        .modelFetchAllDosen!.data[index];

                                    return Container(
                                      width: MediaQuery.of(context).size.width /
                                          2.3,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              3.4,
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
                                                      BorderRadius.circular(5),
                                                  child: Image.network(
                                                    dataDosen.fotoDosen,
                                                    width: double.infinity,
                                                    height: 140.0,
                                                    fit: BoxFit.cover,
                                                    errorBuilder:
                                                        (BuildContext context,Object exception,StackTrace?stackTrace) {
                                                      return const Center(
                                                        child: Icon(
                                                          Icons.person, // Ikon yang ditampilkan saat gambar gagal dimuat
                                                          size: 120.0,
                                                          color: Colors.grey,
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                                const SizedBox(height: 5),
                                                Text(
                                                  dataDosen.namaDosen,
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                const SizedBox(height: 5),
                                                Text(
                                                  dataDosen.nip,
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w200,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            buttonCard(
                                              text: "Lihat",
                                              bgColor: const Color(0xFF0067AC),
                                              onPressed: () async {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        DetailDosen(
                                                      id: dataDosen.idDosen,
                                                      username: widget.username,
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }

  Widget mahasiswaPage() {
    return Consumer<ViewModelHome>(
      builder: (context, model, child) {
        if (viewModel.modelFetchAllMahasiswa != null) {
          final Map<String, int> statusPriority = {
            'Bahaya': 0,
            'Cukup': 1,
            'Aman': 2,
          };

          viewModel.modelFetchAllMahasiswa!.data.sort((a, b) {
            return statusPriority[a.status]! - statusPriority[b.status]!;
          });
        }

        return viewModel.isLoading
            ? RefreshIndicator(
                onRefresh: () async {
                  await viewModel.fetchAllMahasiswa();
                },
                child: SafeArea(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 85.0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const CircleAvatar(
                                        backgroundColor: Colors.white,
                                        child: Icon(
                                          Icons.person,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      const SizedBox(width: 7),
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
                                          Radius.circular(6.0),
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
                      ),
                      Expanded(
                        child: ListView(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: Text(
                                'Mahasiswa Informatika',
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Center(
                              child: Wrap(
                                spacing: 10.0,
                                runSpacing: 10.0,
                                children: List.generate(
                                  viewModel.modelFetchAllMahasiswa!.data.length,
                                  (index) {
                                    final dataMahasiswa = viewModel
                                        .modelFetchAllMahasiswa!.data[index];

                                    return Container(
                                      width: MediaQuery.of(context).size.width /
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
                                                      BorderRadius.circular(5),
                                                  child: Image.network(
                                                    dataMahasiswa.fotoMahasiswa,
                                                    width: double.infinity,
                                                    height: 120.0,
                                                    fit: BoxFit.cover,
                                                    errorBuilder:
                                                        (BuildContext context,Object exception,StackTrace?stackTrace) {
                                                      return const Center(
                                                        child: Icon(
                                                          Icons.person, // Ikon yang ditampilkan saat gambar gagal dimuat
                                                          size: 120.0,
                                                          color: Colors.grey,
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                                const SizedBox(height: 5),
                                                Text(
                                                  dataMahasiswa.nama,
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                const SizedBox(height: 5),
                                                Text(
                                                  dataMahasiswa.nim,
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w200,
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
                                                        dataMahasiswa.status,
                                                      ),
                                                    ),
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                      Radius.circular(3.0),
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      dataMahasiswa.status,
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color: viewModel
                                                            .getStatusColor(
                                                          dataMahasiswa.status,
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
                                              bgColor: const Color(0xFF0067AC),
                                              onPressed: () async {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        DetailMahasiswa(
                                                      id: dataMahasiswa
                                                          .idMahasiswa,
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages()[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: const Color(0xFF3063C3),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Dosen',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Mahasiswa',
          ),
        ],
      ),
      floatingActionButton: _currentIndex == 0
          ? FloatingActionButton(
              backgroundColor: const Color(0xFF3063C3),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddDosen(
                      username: widget.username,
                    ),
                  ),
                );
              },
              child: const Icon(Icons.add),
            )
          : _currentIndex == 1
              ? FloatingActionButton(
                  backgroundColor: const Color(0xFF3063C3),
                  onPressed: () async {
                    await viewModel.downloadAllMahasiswaData();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Data mahasiswa berhasil diunduh."),
                      ),
                    );
                  },
                  child: const Icon(Icons.download),
                )
              : null,
    );
  }
}
