import 'package:flutter/material.dart';
import 'package:uni_events/services/database.dart';

class RandomEventSchedule with ChangeNotifier {
  String? event;

  final Database _db = Database();

  Future generateEvent() async {
    event = await _db.generateRandomEvent();
    notifyListeners();
  }
}
