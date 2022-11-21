import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DesignTF extends StatelessWidget {
  final String text;
  final Color color1;
  final double size;

  const DesignTF(
      {required this.text, required this.color1, required this.size});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.breeSerif(color: color1, fontSize: size),
    );
  }
}
