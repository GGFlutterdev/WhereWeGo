import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditEventSchedule with ChangeNotifier{

  EditEventSchedule({
    required String name,
    required String description,
    required String city,
    required String location,
    required Timestamp? when,
    required String posterUrl,
    required this.uid,
  }) : 
  _name = name,
  _description = description,
  _city = city,
  _location = location,
  _when = when,
  _posterUrl = posterUrl;


  final ImagePicker _picker = ImagePicker();
  String _name = '';
  String _description = '';
  String _city = '';
  String _location = '';
  File? _poster;
  String _posterUrl = '';
  Timestamp? _when;
  final String uid;

  String get name => _name;
  String get description => _description;
  String get city => _city;
  String get location => _location;
  File? get poster => _poster;
  Timestamp? get when => _when;
  String get posterUrl => _posterUrl;

  set posterUrl(String newValue){
    _posterUrl = newValue;
    notifyListeners();
  }
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
}
