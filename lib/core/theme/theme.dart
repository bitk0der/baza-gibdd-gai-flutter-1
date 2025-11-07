import 'package:flutter/material.dart';
import 'package:baza_gibdd_gai/core/theme/app_colors.dart';

final defaultTheme = ThemeData(
  appBarTheme: appBarTheme,
  fontFamily: 'Roboto',
  inputDecorationTheme: inputDecorationTheme,
  bottomNavigationBarTheme: bottomNavBarTheme,
  buttonTheme: buttonThemeData,
  colorScheme: ColorScheme(
    primaryContainer: ColorStyles.white.withOpacity(0.15),
    secondaryContainer: ColorStyles.white.withOpacity(0.1),
    onSecondaryContainer: ColorStyles.white,
    brightness: Brightness.dark,
    primary: ColorStyles.primaryBlue,
    onPrimary: ColorStyles.white,
    secondary: ColorStyles.secondaryBlue,
    onSecondary: ColorStyles.black,
    error: ColorStyles.white,
    onError: ColorStyles.white,
    surface: ColorStyles.white,
    onSurface: Colors.black,
  ),
);

var buttonThemeData = const ButtonThemeData(
  colorScheme: ColorScheme(
    brightness: Brightness.dark,
    primary: ColorStyles.green,
    onPrimary: ColorStyles.white,
    secondary: ColorStyles.white,
    onSecondary: ColorStyles.white,
    error: ColorStyles.white,
    onError: ColorStyles.white,
    surface: ColorStyles.white,
    onSurface: Colors.white,
  ),
);

var bottomNavBarTheme = BottomNavigationBarThemeData(
  /* selectedLabelStyle: UIFonts.selectedLabelStyle,
    unselectedLabelStyle:
        UIFonts.selectedLabelStyle.copyWith(color: ColorStyles.white.withOpacity(0.6)), */
  selectedItemColor: ColorStyles.orange,
  unselectedItemColor: ColorStyles.white.withOpacity(0.6),
);

var appBarTheme = const AppBarTheme(
  backgroundColor: ColorStyles.secondaryBlue,
  surfaceTintColor: ColorStyles.secondaryBlue,
);

var inputDecorationTheme = InputDecorationTheme(
  fillColor: ColorStyles.fillColor,
  errorStyle: const TextStyle(color: Colors.red, height: 2),
  isDense: true,
  border: defaultBorder,
  iconColor: ColorStyles.orange,
  enabledBorder: defaultBorder,
  focusedBorder: focusedBorder,
  focusedErrorBorder: errorBorder,
  errorBorder: errorBorder,
);

var errorBorder = OutlineInputBorder(
  borderSide: const BorderSide(width: 0, color: Colors.transparent),
  borderRadius: BorderRadius.circular(20),
);
var focusedBorder = OutlineInputBorder(
  borderSide: const BorderSide(width: 1, color: ColorStyles.green),
  borderRadius: BorderRadius.circular(20),
);
var defaultBorder = OutlineInputBorder(
  borderSide: const BorderSide(width: 1, color: Colors.transparent),
  borderRadius: BorderRadius.circular(20),
);
