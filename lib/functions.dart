import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni_events/models/city.dart';

String makeGoodExceptions(String e){
  return e.substring(e.lastIndexOf(']')+2);
}

Future<List<City>> getCities() async{
  final List<dynamic> data = jsonDecode(
    await rootBundle.loadString('assets/cities.json'),
  ) as List<dynamic>;
  final List<City> citiesRes = data.map(
    (data) => City.fromJson(data as Map<String, dynamic>),
  ).toList();
  return citiesRes;
}

bool containsIgnoreCase(String string1, String string2) {
  return string1.toLowerCase().contains(string2.toLowerCase());
}

Future<String?> getMainCity() async {
  final SharedPreferences _preferences = await SharedPreferences.getInstance();
  return _preferences.getString('mainCity');
}

Future<void> setMainCity(String city) async {
  final SharedPreferences _preferences = await SharedPreferences.getInstance();
  await _preferences.setString('mainCity', city);
}
