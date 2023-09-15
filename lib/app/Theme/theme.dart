import 'package:flutter/material.dart';
import 'package:flutter_chat_app/app/Theme/colors.dart';
import 'package:flutter_chat_app/app/Theme/typography.dart';

ThemeData lightThemeData(BuildContext context) {
  return ThemeData(
    useMaterial3: true,
    textTheme: textTheme,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: whiteColor,
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.all(primaryColor),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: whiteColor,
      titleTextStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: textColor,
          ),
      elevation: 0,
      iconTheme: const IconThemeData(
        color: textColor,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        minimumSize: const Size(double.infinity, 50),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      hintStyle: TextStyle(
        color: Color(0xFFA2A4A3),
        fontSize: 16,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w400,
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 10),
      filled: true,
      fillColor: Color(0x9ED9F1E5),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 0.50, color: Color(0x9ED9F1E5)),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(width: 0.50, color: Color(0x9ED9F1E5)),
      ),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.all<Color>(whiteColor),
      trackColor: MaterialStateProperty.all<Color>(primaryColor),

      // Set the track height
      // Add other customization properties as needed
    ),
    dataTableTheme: DataTableThemeData(
      headingTextStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
            color: headlineText,
          ),
      dataTextStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
            color: headlineText,
          ),
    ),
    indicatorColor: primaryColor,
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: headlineText,
    ),
  );
}
