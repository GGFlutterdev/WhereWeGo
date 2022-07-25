import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uni_events/functions.dart';
import 'package:uni_events/models/city.dart';
import 'package:uni_events/services/database.dart';

class HomeSchedule with ChangeNotifier{

  final GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();

  final _db = Database();
  String? _city;
  Timestamp? _when;
  List<City> _cities = [];
  List<String> events  = [];
  List<String> nextEvents = [];

  HomeSchedule.initialize() {
    getCity();
    loadCities();
    loadEvents();
  }

  String? get city => _city;
  Timestamp? get when => _when;
  List<City> get cities => _cities;

  set cities(List<City> newValue){
    _cities = newValue;
    notifyListeners();
  }

  set city(String? newValue){
    _city = newValue;
    notifyListeners();
  }

  set when(Timestamp? newValue){
    _when = newValue;
    notifyListeners();
  }

  void resetFilters(){
    _city = null;
    _when = null;
    notifyListeners();
  }

  void applyFilters(){
    events = [];
    loadEvents();
    notifyListeners();
  }

  Future loadEvents() async{
    events = await _db.getLazyEventsUids(_city, _when);
    notifyListeners();
  }

  Future loadCities() async{
    _cities = await getCities();
  }

  Future<int> loadNextLazyAnnouncements() async{
    nextEvents = await _db.getLazyEventsUidNext(events.last, _city, _when);
    events = events + nextEvents;
    notifyListeners();
    return nextEvents.length;
  }

  Future getCity() async{
    _city = await getMainCity();
  }
}
