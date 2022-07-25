import 'package:cloud_firestore/cloud_firestore.dart';

class Event{
  String uid;
  String author;
  String name;
  String description;
  String posterUrl;
  String city;
  String location;
  String category;
  Timestamp when;
  Timestamp created;

  Event({
    required this.uid,
    required this.author,
    required this.name,
    required this.description,
    required this.posterUrl,
    required this.city,
    required this.category,
    required this.location,
    required this.when,
    required this.created,
  });
}
