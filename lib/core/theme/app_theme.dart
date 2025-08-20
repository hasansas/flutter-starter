import 'package:flutter/material.dart';

/// Extra colors used across the app
extension CustomColorScheme on ColorScheme {
  Color get shadowColorLight => Colors.grey.withValues(alpha: 0.08);
  Color get shadowColorDark => Colors.black.withValues(alpha: 0.12);
}

/// App-wide theme
class AppTheme {
  AppTheme._();

  // Base primary color
  static const int _primaryColor = 0xFF2F80ED;
  static const int _secondaryColor = 0xFFEA4C89;
  static const int _disabledColor = 0xFFBDBDBD;

  static const MaterialColor primarySwatch =
      MaterialColor(_primaryColor, <int, Color>{
        50: Color(0xFFEAF4FF),
        100: Color(0xFFCCE4FF),
        200: Color(0xFFAAD3FF),
        300: Color(0xFF87C1FE),
        400: Color(0xFF6EB3FE),
        500: Color(_primaryColor),
        600: Color(0xFF4D9EFE),
        700: Color(0xFF3D95FE),
        800: Color(0xFF2F80ED),
        900: Color(0xFF1C6CEB),
      });

  static const String fontFamily = 'OpenSans';

  // --------------------
  // Typography Scale
  // --------------------
  static final TextStyle displayLarge = TextStyle(
    fontSize: 57,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.25,
    fontFamily: fontFamily,
  );
  static final TextStyle displayMedium = TextStyle(
    fontSize: 45,
    fontWeight: FontWeight.w400,
    fontFamily: fontFamily,
  );
  static final TextStyle displaySmall = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.w400,
    fontFamily: fontFamily,
  );

  static final TextStyle headlineLarge = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w400,
    fontFamily: fontFamily,
  );
  static final TextStyle headlineMedium = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w400,
    fontFamily: fontFamily,
  );
  static final TextStyle headlineSmall = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w400,
    fontFamily: fontFamily,
  );

  static final TextStyle titleLarge = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.15,
    fontFamily: fontFamily,
  );
  static final TextStyle titleMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    fontFamily: fontFamily,
  );
  static final TextStyle titleSmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    fontFamily: fontFamily,
  );

  static final TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
    fontFamily: fontFamily,
  );
  static final TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    fontFamily: fontFamily,
  );
  static final TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
    fontFamily: fontFamily,
  );

  static final TextStyle labelLarge = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
    fontFamily: fontFamily,
  );
  static final TextStyle labelMedium = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    fontFamily: fontFamily,
  );
  static final TextStyle labelSmall = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
    fontFamily: fontFamily,
  );

  /// ===================
  /// Light Theme
  /// ===================
  static ThemeData get light {
    final base = ThemeData.light(useMaterial3: true);

    return base.copyWith(
      colorScheme: ColorScheme.fromSeed(
        primary: primarySwatch,
        secondary: const Color(_secondaryColor),
        seedColor: const Color(_primaryColor),
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: Colors.white,
      disabledColor: const Color(_disabledColor),

      // AppBar baseline
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
        titleTextStyle: titleLarge.copyWith(color: Colors.black),
      ),

      // Input Decoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFFF4F4F6),
        labelStyle: TextStyle(color: Colors.grey.shade600),
        hintStyle: TextStyle(color: Colors.grey.shade400),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 16.0,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey..withValues(alpha: 0.2)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey..withValues(alpha: 0.4)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(_primaryColor), width: 2.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 2.0),
        ),
      ),

      // Card baseline
      cardTheme: CardThemeData(
        elevation: 1,
        margin: const EdgeInsets.all(8),
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        shadowColor: Colors.grey.withValues(alpha: 0.08),
      ),

      // Button baseline
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          minimumSize: const Size(64, 48), // baseline button height
          padding: const EdgeInsets.symmetric(horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: labelLarge,
        ),
      ),

      // Text Theme baseline
      textTheme: TextTheme(
        displayLarge: displayLarge.copyWith(color: Colors.black),
        displayMedium: displayMedium.copyWith(color: Colors.black),
        displaySmall: displaySmall.copyWith(color: Colors.black),
        headlineLarge: headlineLarge.copyWith(color: Colors.black),
        headlineMedium: headlineMedium.copyWith(color: Colors.black),
        headlineSmall: headlineSmall.copyWith(color: Colors.black),
        titleLarge: titleLarge.copyWith(color: Colors.black),
        titleMedium: titleMedium.copyWith(color: Colors.black),
        titleSmall: titleSmall.copyWith(color: Colors.black),
        bodyLarge: bodyLarge.copyWith(color: Colors.black87),
        bodyMedium: bodyMedium.copyWith(color: Colors.black87),
        bodySmall: bodySmall.copyWith(color: Colors.black54),
        labelLarge: labelLarge.copyWith(color: Colors.black),
        labelMedium: labelMedium.copyWith(color: Colors.black),
        labelSmall: labelSmall.copyWith(color: Colors.black),
      ),

      // Dialog baseline
      dialogTheme: DialogThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: Colors.white,
        titleTextStyle: titleLarge.copyWith(color: Colors.black),
        contentTextStyle: bodyMedium.copyWith(color: Colors.black87),
      ),

      // Snackbar baseline
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.black87,
        contentTextStyle: bodyMedium.copyWith(color: Colors.white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  /// ===================
  /// Dark Theme
  /// ===================
  static const Color secondaryColorDark = Colors.white;
  static const Color headlineColorDark = Color(0xFFFFFFFF);
  static const Color subtitleColorDark = Color(0xFFFFFFFF);
  static const Color bodyColorDark = Color(0xFFFFFFFF);
  static const Color shadowColorDark = Color(0xFF424242);
  static const Color appBarBackgroundColorDark = Color(0xFF212121);

  static ThemeData get dark {
    final base = ThemeData.dark(useMaterial3: true);

    return base.copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(_primaryColor),
        brightness: Brightness.dark,
      ),
      scaffoldBackgroundColor: Colors.black,

      // AppBar baseline
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        centerTitle: true,
        titleTextStyle: titleLarge.copyWith(color: Colors.white),
      ), // Input Decoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: shadowColorDark,
        labelStyle: const TextStyle(color: subtitleColorDark),
        hintStyle: const TextStyle(color: subtitleColorDark),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 16.0,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: subtitleColorDark.withValues(alpha: 0.4),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: subtitleColorDark.withValues(alpha: 0.6),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primarySwatch, width: 2.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 2.0),
        ),
      ),

      // Card baseline
      cardTheme: CardThemeData(
        elevation: 1,
        margin: const EdgeInsets.all(8),
        color: const Color(0xFF1E1E1E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        shadowColor: Colors.black.withValues(alpha: 0.12),
      ),

      // Button baseline
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          minimumSize: const Size(64, 48),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: labelLarge,
        ),
      ),

      // Text Theme baseline
      textTheme: TextTheme(
        displayLarge: displayLarge.copyWith(color: Colors.white),
        displayMedium: displayMedium.copyWith(color: Colors.white),
        displaySmall: displaySmall.copyWith(color: Colors.white),
        headlineLarge: headlineLarge.copyWith(color: Colors.white),
        headlineMedium: headlineMedium.copyWith(color: Colors.white),
        headlineSmall: headlineSmall.copyWith(color: Colors.white),
        titleLarge: titleLarge.copyWith(color: Colors.white),
        titleMedium: titleMedium.copyWith(color: Colors.white),
        titleSmall: titleSmall.copyWith(color: Colors.white),
        bodyLarge: bodyLarge.copyWith(color: Colors.white),
        bodyMedium: bodyMedium.copyWith(color: Colors.white70),
        bodySmall: bodySmall.copyWith(color: Colors.white54),
        labelLarge: labelLarge.copyWith(color: Colors.white),
        labelMedium: labelMedium.copyWith(color: Colors.white),
        labelSmall: labelSmall.copyWith(color: Colors.white),
      ),

      // Dialog baseline
      dialogTheme: DialogThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: const Color(0xFF1E1E1E),
        titleTextStyle: titleLarge.copyWith(color: Colors.white),
        contentTextStyle: bodyMedium.copyWith(color: Colors.white70),
      ),

      // Snackbar baseline
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.white,
        contentTextStyle: bodyMedium.copyWith(color: Colors.black),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
