import 'package:flutter/material.dart';

class SignInSchedule with ChangeNotifier{
  String _email = '';
  String _password = '';
  String _username = '';
  bool _showSignIn = true;

  bool get showSignIn => _showSignIn;
  String get email => _email;
  String get password => _password;
  String get username => _username;

  //TO DO:
  void resetPAssword(){}

  set email(String newValue){
    _email = newValue;
    notifyListeners();
  }

  set password(String newValue){
    _password = newValue;
    notifyListeners();
  }

  set username(String newValue){
    _username = newValue;
    notifyListeners();
  }

  void toggleShowSignIn(){
    _showSignIn = !_showSignIn;
    notifyListeners();
  }

  bool validateEmail(){
    return RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$').hasMatch(_email);
  }

 bool validatePassword(){
    /**
     * const String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    final RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(_password);
     */
    return _password.isNotEmpty;
  }

  bool validateUsername() {
    return _username.isNotEmpty && _username.length<36;
  }

  bool clickableSignIn(){
    return validateEmail() && validatePassword();
  }

  bool clickableRegister(){
    return validateEmail() && validatePassword() && validateUsername();
  }
}
