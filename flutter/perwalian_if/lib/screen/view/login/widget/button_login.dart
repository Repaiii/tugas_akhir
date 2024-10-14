import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buttonLogin({
  String? labelText,
  Color? bgColor,
  VoidCallback? onPressed,
  String? text,
}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      backgroundColor: bgColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    onPressed: onPressed,
    child: SizedBox(
      width: double.infinity,
      child: Center(
        child: Text(
          text ?? "",
          style: GoogleFonts.poppins(
            color: const Color(0xFFFAFAFA),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ),
  );
}
