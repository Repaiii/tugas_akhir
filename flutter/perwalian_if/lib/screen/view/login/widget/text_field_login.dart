import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

Widget textFieldLogin({
  required TextEditingController controller,
  Widget? prefixIcon,
  Widget? sufixIcon,
  String? labelText,
  bool? obscureText,
  TextInputType? keyboardType,
  List<TextInputFormatter>? inputFormatters,
  String? Function(String?)? validator,
  TextCapitalization textCapitalization = TextCapitalization.none,
}) {
  return TextFormField(
    textCapitalization: textCapitalization,
    keyboardType: keyboardType,
    inputFormatters: inputFormatters,
    controller: controller,
    obscureText: obscureText ?? false,
    decoration: InputDecoration(
      contentPadding: const EdgeInsets.symmetric(vertical: 8),
      filled: true,
      fillColor: Colors.white,
      hintText: labelText,
      hintStyle: GoogleFonts.poppins(
        color: const Color(0xFFBDB7B6),
        fontSize: 13,
      ),
      labelStyle: const TextStyle(
        color: Colors.blueGrey,
      ),
      prefixIcon: prefixIcon,
      suffixIcon: sufixIcon,
      border: InputBorder.none,
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        borderSide: BorderSide(
          color: Color(0xFFBDB7B6),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(
          color: Colors.black,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(
          color: Colors.red,
        ),
      ),
    ),
    validator: validator,
  );
}
