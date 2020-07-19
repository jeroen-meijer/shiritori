import 'package:flutter/material.dart';
import 'package:shiritori/assets/assets.dart';

// ignore: avoid_classes_with_only_static_members
abstract class AppTheme {
  static ThemeData get themeDataLight {
    return ThemeData(
      buttonTheme: buttonTheme,
      cardTheme: cardTheme,
      dividerTheme: dividerTheme,
      fontFamily: Fonts.hurmeGeometricSans,
      scaffoldBackgroundColor: veryLightGrey,
      textTheme: textTheme,
    );
  }

  static const buttonTheme = ButtonThemeData(
    buttonColor: blue,
  );

  static const _elevation = 18.0;
  static const cardTheme = CardTheme(
    color: white,
    elevation: _elevation,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(radiusCardDefault),
    ),
  );

  static const dividerTheme = DividerThemeData(
    thickness: 2.0,
    space: 4.0,
  );

  static const _letterSpacing = -0.5;
  static const textTheme = TextTheme(
    headline1: TextStyle(
      color: white,
      fontWeight: FontWeight.bold,
      height: 1.0,
      letterSpacing: _letterSpacing,
    ),
    headline2: TextStyle(
      color: white,
      height: 1.0,
      fontWeight: FontWeight.bold,
      letterSpacing: _letterSpacing,
    ),
    headline3: TextStyle(
      color: white,
      height: 1.0,
      fontWeight: FontWeight.bold,
      letterSpacing: _letterSpacing,
    ),
    headline4: TextStyle(
      color: blue,
      height: 1.0,
      fontWeight: FontWeight.bold,
      letterSpacing: _letterSpacing,
    ),
    headline5: TextStyle(
      color: blue,
      height: 1.0,
      fontWeight: FontWeight.bold,
      letterSpacing: _letterSpacing,
    ),
    headline6: TextStyle(
      color: blue,
      height: 1.0,
      fontWeight: FontWeight.bold,
      letterSpacing: _letterSpacing,
    ),
    overline: TextStyle(
      color: blue,
      fontWeight: FontWeight.bold,
      letterSpacing: _letterSpacing,
    ),
    subtitle1: TextStyle(
      color: blue,
      fontWeight: FontWeight.w600,
      letterSpacing: _letterSpacing,
    ),
    subtitle2: TextStyle(
      color: blue,
      fontWeight: FontWeight.w600,
      letterSpacing: _letterSpacing,
    ),
  );

  static const white = Color(0xFFFFFFFF);
  static const veryLightGrey = Color(0xFFF2F5FA);
  static const lightGrey = Color(0xFFAFBEDA);
  static const grey = Color(0xFF666889);

  static const lightYellow = Color(0xFFE0D984);
  static const yellow = Color(0xFFFFE263);
  static const orange = Color(0xFFFC9C45);
  static const darkOrange = Color(0xFFFA6E46);
  static const pink = Color(0xFFE74475);
  static const blurple = Color(0xFF444DFF);
  static const darkBlue = Color(0xFF0838AE);
  static const blue = Color(0xFF2D56D3);
  static const lightBlue = Color(0xFF40D5FC);
  static const lightestBlue = Color(0xFF78E2FC);
  static const cyan = Color(0xFF6DE2BA);
  static const green = Color(0xFF77D65A);

  static const radiusCardDefault = Radius.circular(16.0);

  static const curveDefault = Curves.easeOutQuint;

  static const durationAnimationDefault = Duration(milliseconds: 300);
}
