import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resources/styles/color.dart';

// text style
final TextStyle kHeading5 =
    GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w400);
final TextStyle kHeading6 = GoogleFonts.poppins(
  fontSize: 18,
  fontWeight: FontWeight.w500,
  letterSpacing: 0.15,
  color: kPurplePrimary,
);
final TextStyle kSubtitle = GoogleFonts.poppins(
    fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.15);
final TextStyle kBodyText = GoogleFonts.poppins(
    fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.25);

// text theme
final kTextTheme = TextTheme(
  headlineMedium: kHeading5,
  headlineLarge: kHeading6,
  bodyMedium: kSubtitle,
  bodySmall: kBodyText,
);
