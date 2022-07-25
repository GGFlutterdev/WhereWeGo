import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddEventSchedule with ChangeNotifier{
  final ImagePicker _picker = ImagePicker();
  String _name = '';
  String _description = '';
  String _city = '';
  String _location = '';
  File? _poster;
  Timestamp? _when;

  String get name => _name;
  String get description => _description;
  String get city => _city;
  String get location => _location;
  File? get poster => _poster;
  Timestamp? get when => _when;

  set name(String newValue){
    _name = newValue;
    notifyListeners();
  }
  set description(String newValue){
    _description = newValue;
    notifyListeners();
  }
  set city(String newValue){
    _city = newValue;
    notifyListeners();
  }
  set location(String newValue){
    _location = newValue;
    notifyListeners();
  }
  set when(Timestamp? newValue){
    _when = newValue;
    notifyListeners();
    
  }

  Future<void> pickImageFromGallery() async{
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
    );
    if(pickedFile != null){
      _poster = File(
        pickedFile.path,
      );
      notifyListeners();
    }
  }

  bool validateFields(){
    return _name.isNotEmpty && _description.isNotEmpty && _city.isNotEmpty && _location.isNotEmpty && _poster != null;
  }
}
