import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni_events/constants.dart';

class ThemingSchedule with ChangeNotifier{

  static Future<ThemeMode> get currentTheme async {
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    return _prefs.then((SharedPreferences prefs) {
      return prefs.getBool('isDarkTheme') == true ? ThemeMode.dark : ThemeMode.light;
    });
  } 

  Future toggleTheme() async{
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    final bool actual = !(prefs.getBool('isDarkTheme')??false);
    return prefs.setBool('isDarkTheme', actual).then((bool success) {
      notifyListeners();
      return actual == true ? ThemeMode.dark : ThemeMode.light;
    });
  }

  static ThemeData get lightTheme{
    return ThemeData(
      timePickerTheme: TimePickerThemeData(
        entryModeIconColor: kPrimaryColor,
        hourMinuteColor: kPrimaryColor,
        dayPeriodColor: kPrimaryColor,
        dayPeriodTextColor: kPrimaryColor,
        dialHandColor: kPrimaryColor,
        dialTextColor: lightPrimaryTextColor,
        dialBackgroundColor: Colors.grey[400],
        hourMinuteTextColor: lightPrimaryBackgroundColor,
        helpTextStyle: GoogleFonts.openSans(
          textStyle: const TextStyle(
            color: lightPrimaryTextColor,
            fontSize: 15,
          ),
        ),
      ),
      shadowColor: Colors.grey[300],
      highlightColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
      cardColor: Colors.white,
      primaryColor: kPrimaryColor,
      backgroundColor: const Color(0xFF00293E),
      scaffoldBackgroundColor: lightPrimaryBackgroundColor,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        color: kPrimaryColor,
      ),
      textTheme: TextTheme(
        headline1: GoogleFonts.inter(
          textStyle: const TextStyle(
            color: lightPrimaryTextColor,
            fontSize: 30,
          ),
        ),
        headline2: GoogleFonts.inter(
          textStyle: const TextStyle(
            color: lightPrimaryTextColor,
            fontSize: 28,
          ),
        ),
        bodyText1: GoogleFonts.inter(
          textStyle: const TextStyle(
            color: lightPrimaryTextColor,
            fontSize: 20,
          ),
        ),
        bodyText2: GoogleFonts.inter(
          textStyle: const TextStyle(
            color: lightPrimaryTextColor,
            fontSize: 15,
          ),
        ),
        subtitle1: GoogleFonts.inter(
          textStyle: const TextStyle(
            color: lightPrimaryTextColor,
            fontSize: 17,
          ),
        ),
        subtitle2: GoogleFonts.inter(
          textStyle: const TextStyle(
            color: lightPrimaryTextColor,
            fontSize: 9,
          ),
        ),
        caption: GoogleFonts.inter(
          textStyle: const TextStyle(
            color: lightPrimaryTextColor,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
  
  static ThemeData get darkTheme{
    return ThemeData(
      timePickerTheme: TimePickerThemeData(
        entryModeIconColor: const Color.fromRGBO(232, 173, 95, 1),
        hourMinuteColor: const Color.fromRGBO(232, 173, 95, 1),
        dayPeriodColor: const Color.fromRGBO(232, 173, 95, 1),
        dayPeriodTextColor: const Color.fromRGBO(232, 173, 95, 1),
        dialHandColor: const Color.fromRGBO(232, 173, 95, 1),
        dialTextColor: darkPrimaryTextColor,
        hourMinuteTextColor: darkPrimaryBackgroundColor,
        helpTextStyle: GoogleFonts.openSans(
          textStyle: const TextStyle(
            color: darkPrimaryTextColor,
            fontSize: 15,
          ),
        ),
      ),
      shadowColor: Colors.grey[900],
      highlightColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        color: Color.fromRGBO(232, 173, 95, 1),
      ),
      cardColor: const Color(0xFF141517),
      backgroundColor: Colors.black,
      primaryColor: kPrimaryColor,
      scaffoldBackgroundColor: darkPrimaryBackgroundColor,
      textTheme: TextTheme(
        headline1: GoogleFonts.inter(
          textStyle: const TextStyle(
            color: darkPrimaryTextColor,
            fontSize: 30,
          ),
        ),
        headline2: GoogleFonts.inter(
          textStyle: const TextStyle(
            color: darkPrimaryTextColor,
            fontSize: 28,
          ),
        ),
        bodyText1: GoogleFonts.inter(
          textStyle: const TextStyle(
            color: darkPrimaryTextColor,
            fontSize: 20,
          ),
        ),
        bodyText2: GoogleFonts.inter(
          textStyle: const TextStyle(
            color: darkPrimaryTextColor,
            fontSize: 15,
          ),
        ),
        subtitle1: GoogleFonts.inter(
          textStyle: const TextStyle(
            color: darkPrimaryTextColor,
            fontSize: 17,
          ),
        ),
        subtitle2: GoogleFonts.inter(
          textStyle: const TextStyle(
            color: darkPrimaryTextColor,
            fontSize: 9,
          ),
        ),
        caption: GoogleFonts.inter(
          textStyle: const TextStyle(
            color: darkPrimaryTextColor,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
