import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:uni_events/services/demolocalizationsdelegate.dart';

const supportedLocales =  [  
  Locale('it', 'IT'),  
  Locale('en', 'US')
];

Locale localeResolutionCallback(Locale? locale, Iterable<Locale>? supportedLocales) {  
  for (final Locale supportedLocale in supportedLocales!) {  
    if (supportedLocale.languageCode == locale!.languageCode || supportedLocale.countryCode == locale.countryCode) {  
      return supportedLocale;  
    }  
  }  
  return supportedLocales.first;  
}

const Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates = [  
  DemoLocalizationsDelegate(),  
  GlobalMaterialLocalizations.delegate,  
  GlobalWidgetsLocalizations.delegate,
];

const Iterable<LocalizationsDelegate<dynamic>> iosLocalizationsDelegates = [  
  DemoLocalizationsDelegate(),  
  GlobalMaterialLocalizations.delegate,  
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
];

const kPrimaryColor = Color(0xFFFC03A1);

const double cardHeight = 436;

const darkPrimaryTextColor = Colors.white;
const lightPrimaryTextColor = Colors.white;
const lightPrimaryBackgroundColor = Colors.black;
const darkPrimaryBackgroundColor= Color(0xFF202124);

const double propicSize = 50;
const double eventPosterHeight = 406;
const double buttonHeight = 60;
