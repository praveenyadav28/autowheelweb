import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A generic [openSansTextStyle] made to fulfill our needs.
/// * [size] - a [double] value represent [fontSize]
/// * [weight] - a [FontWeight] value represent how much [Bold] a [Text] should be.
/// * [color] - a [Color] value

TextStyle rubikTextStyle(double size, FontWeight weight, color) {
  return GoogleFonts.rubik(
    fontSize: size,
    fontWeight: weight,
    color: color,
  );
}

/// A generic [robotoTextStyle] made to fulfill our needs.
/// * [size] - a [double] value represent [fontSize]
/// * [weight] - a [FontWeight] value represent how much [Bold] a [Text] should be.
/// * [color] - a [Color] value
TextStyle robotoTextStyle(double size, FontWeight weight, color) {
  return GoogleFonts.roboto(fontSize: size, fontWeight: weight, color: color);
}

TextStyle poppinsTextStyle(double size, FontWeight weight, color) {
  return GoogleFonts.poppins(fontSize: size, fontWeight: weight, color: color);
}

TextStyle alegreyaTextStyle(double size, FontWeight weight, color) {
  return GoogleFonts.alegreya(fontSize: size, fontWeight: weight, color: color);
}

TextStyle interTextStyle(double size, FontWeight weight, color) {
  return GoogleFonts.inter(fontSize: size, fontWeight: weight, color: color);
}
