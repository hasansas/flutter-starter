import 'package:flutter/material.dart';

extension CustomColorScheme on ColorScheme {
  Color get shadowColorLight => Colors.grey.withOpacity(0.1);
  Color get shadowColorDark => Colors.black.withOpacity(0.1);
}

class AppTheme {
  final ThemeData baseThemeData;

  static AppTheme of(BuildContext context) {
    final baseThemeData = Theme.of(context);
    return AppTheme._(baseThemeData);
  }

  const AppTheme._(this.baseThemeData);

  // Define default color
  static const Color primarySwatch = Colors.red;
  static const Color accentyColor = Colors.red;
  static const Color buttonColor = Colors.red;
  static const Color textColor = Color(0xFF143d63);
  static const Color accentyColorDark = Colors.white;
  static const Color buttonColorDark = Colors.red;
  static const Color textColorDark = Color(0xFFFFFFFF);

  // Define the default font family.
  final String fontFamily = 'Nunito';

  // Define text style.
  TextStyle get _headline1 =>
      TextStyle(fontSize: 102, fontWeight: FontWeight.w300, color: textColor);
  TextStyle get _headline2 =>
      TextStyle(fontSize: 62, fontWeight: FontWeight.w300, color: textColor);
  TextStyle get _headline3 => TextStyle(fontSize: 51, color: textColor);
  TextStyle get _headline4 => TextStyle(fontSize: 36, color: textColor);
  TextStyle get _headline5 => TextStyle(fontSize: 25, color: textColor);
  TextStyle get _headline6 =>
      TextStyle(fontSize: 21, fontWeight: FontWeight.w600, color: textColor);
  TextStyle get _subtitle1 =>
      TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: textColor);
  TextStyle get _subtitle2 =>
      TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: textColor);
  TextStyle get _bodyText1 => TextStyle(fontSize: 17, color: textColor);
  TextStyle get _bodyText2 => TextStyle(fontSize: 15, color: textColor);
  TextStyle get _button =>
      TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white);
  TextStyle get _caption => TextStyle(fontSize: 13, color: textColor);
  TextStyle get _overline => TextStyle(fontSize: 11, color: textColor);

  // Light theme
  ThemeData get lightTheme => ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.light,
        accentColor: accentyColor,
        primarySwatch: primarySwatch,
        buttonColor: buttonColor,

        // Define the default font family.
        fontFamily: fontFamily,

        // Define the default TextTheme.
        textTheme: TextTheme(
          headline1: _headline1,
          headline2: _headline2,
          headline3: _headline3,
          headline4: _headline4,
          headline5: _headline5,
          headline6: _headline6,
          subtitle1: _subtitle1,
          subtitle2: _subtitle2,
          bodyText1: _bodyText1,
          bodyText2: _bodyText2,
          button: _button,
          caption: _caption,
          overline: _overline,
        ).apply(displayColor: textColor.withOpacity(0.7)),

        dividerColor: textColor.withOpacity(0.5),

        // unselectedWidgetColor
        unselectedWidgetColor: textColor.withOpacity(0.5),
      );

  // Dark theme
  ThemeData get darkTheme => ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.dark,
        accentColor: accentyColorDark,
        primarySwatch: primarySwatch,
        buttonColor: buttonColorDark,

        // Define the default font family.
        fontFamily: fontFamily,

        // Define the default TextTheme.
        textTheme: TextTheme(
          headline1: _headline1,
          headline2: _headline2,
          headline3: _headline3,
          headline4: _headline4,
          headline5: _headline5,
          headline6: _headline6,
          subtitle1: _subtitle1,
          subtitle2: _subtitle2,
          bodyText1: _bodyText1,
          bodyText2: _bodyText2,
          button: _button,
          caption: _caption,
          overline: _overline,
        ).apply(
            bodyColor: textColorDark,
            displayColor: textColorDark.withOpacity(0.7)),

        dividerColor: textColorDark.withOpacity(0.5),
      );
}
