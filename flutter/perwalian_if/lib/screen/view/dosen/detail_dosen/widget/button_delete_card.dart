import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buttonDeleteMahasiswa({
  Color? bgColor,
  Color? borderColor,
  Color? textColor,
  VoidCallback? onPressed,
  String? text,
  double? fontSize,
}) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      height: 20,
      width: 60,
      decoration: BoxDecoration(
        color: bgColor,
        border: Border.all(
          color: borderColor ?? Colors.transparent,
        ),
        borderRadius: BorderRadius.circular(2.0),
      ),
      child: Center(
        child: Text(
          "Hapus",
          style: GoogleFonts.poppins(
            fontSize: fontSize,
            fontWeight: FontWeight.w300,
            color: textColor ?? Colors.black, // Warna teks hitam (default)
          ),
        ),
      ),
    ),
  );
}