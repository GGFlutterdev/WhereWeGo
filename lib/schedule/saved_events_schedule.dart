import 'package:flutter/material.dart';
import 'package:uni_events/services/database.dart';

class SavedEventsSchedule with ChangeNotifier{
  final _db = Database();
  final String user;
  List<String> saved  = [];
  List<String> nextSaved = [];

  SavedEventsSchedule.initialize(this.user){
    loadEvents();
  }

  Future loadEvents() async{
    saved = await _db.getSavedLazyEventsUids(user);
    notifyListeners();
  }

  Future<int> loadNextSavedLazyAnnouncements() async{
    nextSaved = await _db.getSavedLazyEventsUidNext(saved.last, user);
    saved = saved + nextSaved;
    notifyListeners();
    return nextSaved.length;
  }
}
