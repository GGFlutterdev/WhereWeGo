import 'package:flutter/material.dart';
import 'package:uni_events/services/database.dart';

class HotEventsSchedule with ChangeNotifier{
  final _db = Database();
  List<String> hotEvents = [];

  HotEventsSchedule.initialize(){
    loadHotEvents();
  }

  Future loadHotEvents() async{
    hotEvents = await _db.getHotEvents();
    notifyListeners();
  }
}
