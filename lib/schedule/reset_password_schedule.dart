import 'package:flutter/material.dart';

class ResetPasswordSchedule with ChangeNotifier{

  String _email = '';

  String get email => _email;

  set email(String newValue){
    _email = newValue;
    notifyListeners();
  }

  bool validateEmail(){
    return RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$').hasMatch(_email);
  }
}
