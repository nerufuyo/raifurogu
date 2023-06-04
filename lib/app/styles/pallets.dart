import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFF3269FF);
const Color secondaryColor = Color(0xFF282828);
const Color thirdColor = Color(0xFFECEBF0);
const Color fourthColor = Color(0xFFFFFFFF);

final customTheme = ThemeData(
  primaryColor: primaryColor,
  scaffoldBackgroundColor: thirdColor,
  colorScheme: ColorScheme.fromSwatch().copyWith(secondary: secondaryColor),
);
