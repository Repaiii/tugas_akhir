import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MahasiswaCard extends StatelessWidget {
  final dynamic data;
  final Function onDelete;

  const MahasiswaCard({super.key, required this.data, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2.25,
      height: MediaQuery.of(context).size.height / 10,
      decoration: BoxDecoration(
        color: const Color(0xFFFEFEFE),
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 0.5,
            blurRadius: 1.0,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(
                data.fotoMahasiswa,
                width: 75,
                height: 75,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.nama,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "${data.nim}",
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    fontWeight: FontWeight.w200,
                  ),
                ),
                const SizedBox(height: 5),
                TextButton(
                  onPressed: () => onDelete(),
                  style: TextButton.styleFrom(
                    foregroundColor: const Color(0xFFC50B0B), padding: EdgeInsets.zero,
                    minimumSize: const Size(50, 30),
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: Color(0xFFC50B0B)),
                    textStyle: GoogleFonts.poppins(fontSize: 10),
                  ),
                  child: const Text("Hapus"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
