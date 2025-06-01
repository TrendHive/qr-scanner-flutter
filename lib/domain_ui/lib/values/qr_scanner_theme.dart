import 'package:domain_ui/values/qr_scanner_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QRScannerTheme {
  QRScannerTheme._();

  static final ThemeData lightTheme = ThemeData.light().copyWith(
    brightness: Brightness.light,
    scaffoldBackgroundColor: QRScannerColor.background01Light,
    colorScheme: const ColorScheme.light().copyWith(
      primary: QRScannerColor.brandDefaultLight,
      surface: QRScannerColor.background02Light,
    ),
    textTheme: GoogleFonts.beVietnamProTextTheme().copyWith(
      titleLarge: const TextStyle(color: QRScannerColor.fontColorTitleLight),
      titleMedium: const TextStyle(color: QRScannerColor.fontColorTitleLight),
      titleSmall: const TextStyle(color: QRScannerColor.fontColorTitleLight),
      bodyLarge: const TextStyle(color: QRScannerColor.fontColorDescLight),
      bodyMedium: const TextStyle(color: QRScannerColor.fontColorDescLight),
      bodySmall: const TextStyle(color: QRScannerColor.fontColorDescLight),
    ),
  );

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: QRScannerColor.background01Dark,
    colorScheme: const ColorScheme.dark().copyWith(
      primary: QRScannerColor.brandDefaultDark,
      surface: QRScannerColor.background02Dark,
    ),
    textTheme: GoogleFonts.beVietnamProTextTheme().copyWith(
      titleLarge: const TextStyle(color: QRScannerColor.fontColorTitleDark),
      titleMedium: const TextStyle(color: QRScannerColor.fontColorTitleDark),
      titleSmall: const TextStyle(color: QRScannerColor.fontColorTitleDark),
      bodyLarge: const TextStyle(color: QRScannerColor.fontColorDescDark),
      bodyMedium: const TextStyle(color: QRScannerColor.fontColorDescDark),
      bodySmall: const TextStyle(color: QRScannerColor.fontColorDescDark),
    ),
  );
}
