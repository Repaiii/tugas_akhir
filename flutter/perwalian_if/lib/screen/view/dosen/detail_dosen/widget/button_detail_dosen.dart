import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buttonDetailDosen({
  Color? bgColor,
  Color? borderColor,
  Color? textColor,
  VoidCallback? onPressed,
  String? text,
  double? widthButton,
  double? fontSize,
}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      backgroundColor: bgColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: borderColor ?? Colors.transparent),
      ),
    ),
    onPressed: onPressed,
    child: SizedBox(
      width: widthButton,
      child: Center(
        child: Text(
          text ?? "",
          style: GoogleFonts.poppins(
            color: textColor,
            fontSize: fontSize,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ),
  );
}
