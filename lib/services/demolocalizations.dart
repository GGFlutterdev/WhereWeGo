import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DemoLocalizations {  
  DemoLocalizations(this.locale);  
  
  final Locale locale;  
  
  static DemoLocalizations? of(BuildContext context) {  
    return Localizations.of<DemoLocalizations>(context, DemoLocalizations);  
  }  
  
  late Map<String, String> _sentences;  
  
  Future<bool> load() async {
    final String data = await rootBundle.loadString('resources/lang/${locale.languageCode}.json');
    final dynamic _result = json.decode(data);

    _sentences = {};
    // ignore: avoid_dynamic_calls
    _result.forEach((String key, dynamic value) {
      _sentences[key] = value.toString();
    });

    return true;
  }
  
  String? trans(String key) {  
    return _sentences[key];  
  }  
}
