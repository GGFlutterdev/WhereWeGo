import 'dart:async';  

import 'package:flutter/material.dart';
import 'package:uni_events/services/demolocalizations.dart';

class DemoLocalizationsDelegate extends LocalizationsDelegate<DemoLocalizations> {  
  const DemoLocalizationsDelegate();  
  
  @override  
  bool isSupported(Locale locale) => ['it', 'en'].contains(locale.languageCode);  
  
  @override  
  Future<DemoLocalizations> load(Locale locale) async {  
    final DemoLocalizations localizations = DemoLocalizations(locale);  
  await localizations.load();
  
  return localizations;  
  }  
  
  @override  
  bool shouldReload(DemoLocalizationsDelegate old) => false;  
}
