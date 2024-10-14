import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buttonCard({
  Color? bgColor,
  VoidCallback? onPressed,
  String? text,
}) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      height: 25.0,
      width: double.infinity,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.all(
          Radius.circular(
            8.0,
          ),
        ),
      ),
      child: Center(
        child: Text(
          text ?? "",
          style: GoogleFonts.poppins(
            color: const Color(0xFFFAFAFA),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ),
  );
  // ElevatedButton(
  //   style: ElevatedButton.styleFrom(
  //     elevation: 0,
  //     backgroundColor: bgColor,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(8),
  //     ),
  //     fixedSize: Size(double.infinity, 10),
  //   ),
  //   onPressed: onPressed,
  //   child: SizedBox(
  //     width: double.infinity,
  //     child: Center(
  //       child: Text(
  //         text ?? "",
  //         style: GoogleFonts.poppins(
  //           color: const Color(0xFFFAFAFA),
  //           fontSize: 13,
  //           fontWeight: FontWeight.w500,
  //         ),
  //       ),
  //     ),
  //   ),
  // );
}
