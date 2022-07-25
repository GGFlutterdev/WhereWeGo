import 'package:flutter/material.dart';
import 'package:uni_events/functions.dart';
import 'package:uni_events/services/database.dart';

class CategorySchedule with ChangeNotifier{

  final GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();
  final _db = Database();
  String? city;
  List<String> events  = [];
  List<String> nextEvents = [];
  late String _category;


  CategorySchedule.initialize(String category){
    _category = category;
    getCity();
    loadEvents();
  }

  Future loadEvents() async{
    events = await _db.getLazyCategoryEventsUids(city, _category);
    notifyListeners();
  }


  Future<int> loadNextLazyAnnouncements() async{
    nextEvents = await _db.getLazyCategoryEventsUidNext(events.last, city, _category);
    events = events + nextEvents;
    notifyListeners();
    return nextEvents.length;
  }

  Future getCity() async{
    city = await getMainCity();
  }

  void loadNextCategoryLazyAnnouncements() {}
}
