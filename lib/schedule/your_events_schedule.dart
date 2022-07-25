import 'package:flutter/material.dart';
import 'package:uni_events/services/database.dart';

class YourEventsSchedule with ChangeNotifier{
  List<String> events  = [];
  List<String> nextEvents = [];
  final _db = Database();

  YourEventsSchedule.initialize(String author){
    loadYourEvents(author);
  }

  Future loadYourEvents(String author) async{
    events = await _db.getYourLazyEventsUids(author);
    notifyListeners();
  }

  Future<int> loadYourNextLazyAnnouncements(String author) async{
    nextEvents = await _db.getYourLazyEventsUidNext(events.last, author);
    events = events + nextEvents;
    notifyListeners();
    return nextEvents.length;
  }
}
