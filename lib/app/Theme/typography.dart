import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

final textTheme = TextTheme(
  displayLarge: GoogleFonts.roboto(
    fontWeight: FontWeight.w400,
    fontSize: 24,
    color: textColor,
  ),
  displayMedium: GoogleFonts.roboto(
    fontWeight: FontWeight.w400,
    fontSize: 18,
    //height: 52 / 45,
    color: textColor,
  ),
  displaySmall: GoogleFonts.roboto(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    height: 44 / 36,
    color: textColor,
  ),
  headlineLarge: GoogleFonts.nunitoSans(
    fontWeight: FontWeight.bold,
    color: textColor,
    fontSize: 32,
    height: 40 / 32,
  ),
  headlineMedium: GoogleFonts.roboto(
    fontWeight: FontWeight.w600,
    fontSize: 28,
    height: 36 / 28,
    color: textColor,
  ),
  headlineSmall: GoogleFonts.roboto(
    fontWeight: FontWeight.w400,
    fontSize: 24,
    height: 32 / 24,
    color: textColor,
  ),
  titleLarge: GoogleFonts.roboto(
    fontWeight: FontWeight.w700,
    fontSize: 22,
    height: 28 / 22,
    color: textColor,
  ),
  titleMedium: GoogleFonts.roboto(
    fontWeight: FontWeight.w600,
    fontSize: 22,
    height: 24 / 16,
    letterSpacing: 0.1,
    color: textColor,
  ),
  titleSmall: GoogleFonts.roboto(
    fontWeight: FontWeight.w600,
    fontSize: 14,
    height: 20 / 14,
    letterSpacing: 0.1,
    color: textColor,
  ),
  labelLarge: GoogleFonts.roboto(
    fontWeight: FontWeight.w700,
    fontSize: 14,
    height: 20 / 14,
    color: textColor,
  ),
  labelMedium: GoogleFonts.roboto(
    fontWeight: FontWeight.w700,
    fontSize: 12,
    height: 16 / 12,
    color: textColor,
  ),
  labelSmall: GoogleFonts.roboto(
    fontWeight: FontWeight.w700,
    fontSize: 11,
    height: 16 / 11,
    color: textColor,
  ),
  bodyLarge: GoogleFonts.roboto(
    fontWeight: FontWeight.w400,
    fontSize: 16,
    height: 24 / 16,
    color: textColor,
  ),
  bodyMedium: GoogleFonts.roboto(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    height: 20 / 14,
    color: textColor,
  ),
  bodySmall: GoogleFonts.roboto(
    fontWeight: FontWeight.w400,
    fontSize: 12,
    height: 16 / 12,
    color: textColor,
  ),
);
final headline = GoogleFonts.museoModerno(
  fontSize: 50,
  fontWeight: FontWeight.w600,
  letterSpacing: 1,
  color: whiteColor,
);
