import 'dart:async';
import 'dart:ui' show Locale;
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class AppLocal {
  String languageCode;
  String countryCode;

  AppLocal(this.languageCode, this.countryCode);
}

List<AppLocal> appSupportedLocales = [
  AppLocal('en', 'US'),
  AppLocal('id', 'ID'),
];

class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;
  static Map<dynamic, dynamic> _localisedValues;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations appTranslations = AppLocalizations(locale);
    String jsonContent =
        await rootBundle.loadString('assets/il10n/${locale.languageCode}.json');
    _localisedValues = json.decode(jsonContent);
    return appTranslations;
  }

  get currentLanguage => locale.languageCode;

  String text(String key) {
    return _localisedValues[key] ?? "$key not found";
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    List<String> supportedLocales = [];
    appSupportedLocales.forEach((lang) {
      supportedLocales.add(lang.languageCode);
    });

    return supportedLocales.contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    return AppLocalizations.load(locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) {
    return false;
  }
}
