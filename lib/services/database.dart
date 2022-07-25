import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uni_events/models/event.dart';
import 'package:uni_events/models/my_user.dart';
import 'package:uni_events/models/saved.dart';

class Database{

  final String? uid;

  Database({
    this.uid,
  });

  final CollectionReference savedCollection = FirebaseFirestore.instance.collection('saved');
  final CollectionReference eventsCollection = FirebaseFirestore.instance.collection('events');
  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

  Stream<MyUser> get userData{ return usersCollection.doc(uid).snapshots().map(_myUserDataFromSnapshot); }
  Stream<Event> get eventData{ return eventsCollection.doc(uid).snapshots().map(_eventData);}
  Stream<Saved> get savedData{ return savedCollection.doc(uid).snapshots().map(_savedDataFromSnapshot);}

  Saved _savedDataFromSnapshot(DocumentSnapshot snapshot){
    return Saved(
      uid:snapshot.id,
      user: snapshot.get('user').toString(),
      event: snapshot.get('event').toString(),
    );
  }

  MyUser _myUserDataFromSnapshot(DocumentSnapshot snapshot){
    return MyUser(
      uid:snapshot.id,
      username: snapshot.get('username').toString(),
      isAdmin: snapshot.get('isAdmin') as bool,
      isSubscribed: snapshot.get('isSubscribed') as bool,
      propic: snapshot.get('propic').toString(),
      numberOfEvents: int.parse(snapshot.get('numberOfEvents').toString()),
    );
  }

  Event _eventData(DocumentSnapshot snapshot){
    return Event(
      uid: snapshot.id,
      author: snapshot.get('author').toString(),
      name: snapshot.get('name').toString(),
      city: snapshot.get('city').toString(),
      created: snapshot.get('created') as Timestamp,
      description: snapshot.get('description').toString(),
      location: snapshot.get('location').toString(),
      posterUrl: snapshot.get('posterUrl').toString(),
      category: snapshot.get('category').toString(),
      when: snapshot.get('when') as Timestamp,
    );
  }

  Future<List<String>> getHotEvents(){
    final List<String> list = [];
    return eventsCollection.orderBy('created', descending: true).get().then((snap){
      for(final doc in snap.docs){
        if(list.length<4){
          list.add(doc.id);
        } else {
          break;
        }
      }
      return list;
    });
  }

  Future<List<String>> getYourLazyEventsUids(String author){
    final List<String> list = [];
    return eventsCollection.orderBy('created', descending: true).get().then((snap){
      for(final doc in snap.docs){
        if(list.length<30 && doc.get('author').toString() == author){
          list.add(doc.id);
        } else {
          break;
        }
      }
      return list;
    });
  }

  Future<List<String>> getYourLazyEventsUidNext(String last, String author) async{
    final List<String> list = [];
    final lastVisible = await eventsCollection.doc(last).get();
    return eventsCollection.orderBy('created', descending: true).startAfterDocument(lastVisible).get().then((snap){
      for(final doc in snap.docs){ 
        if(list.length<30 && doc.get('author').toString() == author){
          list.add(doc.id);
        } else {
          break;
        }
      }
      return list;
    });
  }

  Future<List<String>> getSavedLazyEventsUids(String user){
    final List<String> list = [];
    return savedCollection.get().then((snap){
      for(final doc in snap.docs){
        if(list.length<30){
          if(doc.get('user').toString() == user){
            list.add(doc.id);
          }
        } else {
          break;
        }
      }
      return list;
    });
  }

  Future<List<String>> getSavedLazyEventsUidNext(String last, String user) async{
    final List<String> list = [];
    final lastVisible = await savedCollection.doc(last).get();
    return savedCollection.startAfterDocument(lastVisible).get().then((snap){
      for(final doc in snap.docs){ 
        if(list.length<30 && doc.get('user').toString() == user){
          list.add(doc.get('event').toString());
        } else {
          break;
        }
      }
      return list;
    });
  }

  Future<List<String>> getLazyEventsUids(String? city,Timestamp? when){
    final List<String> list = [];
    return eventsCollection.orderBy('created', descending: true).get().then((snap){
      for(final doc in snap.docs){
        if(list.length<30){
          if(when != null && city==null && (when.toDate()).difference((doc.get('when') as Timestamp).toDate()) <= const Duration( hours: 24)){
            list.add(doc.id);
          } else if(when != null && city != null && doc.get('city').toString() == city && (when.toDate()).difference((doc.get('when') as Timestamp).toDate()) <= const Duration( hours: 24)){
            list.add(doc.id);
          } else if(when == null && city != null && doc.get('city').toString() == city && Timestamp.now().compareTo(doc.get('when') as Timestamp) <= 0){
              list.add(doc.id);
          } else if(when == null && city == null){
            list.add(doc.id);
          }
        } else {
          break;
        }
      }
      return list;
    });
  }

  Future<List<String>> getLazyEventsUidNext(String last, String? city, Timestamp? when) async{
    final List<String> list = [];
    final lastVisible = await eventsCollection.doc(last).get();
    return eventsCollection.orderBy('created', descending: true).startAfterDocument(lastVisible).get().then((snap){
      for(final doc in snap.docs){
        if(list.length<30){
          if(when != null && city==null && (doc.get('when') as Timestamp).toDate().difference(when.toDate()) <= const Duration( hours: 24)){
              list.add(doc.id);
          } else if(when == null && city != null && doc.get('city').toString() == city && Timestamp.now().compareTo(doc.get('when') as Timestamp) <= 0){
              list.add(doc.id);
          } else if(when != null && city != null && doc.get('city').toString() == city && (doc.get('when') as Timestamp).toDate().difference(when.toDate()) <= const Duration( hours: 24)){
            list.add(doc.id);
          } else if(when == null && city == null){
            list.add(doc.id);
          }
        } else {
          break;
        }
      }
      return list;
    });
  }

  Future updateUserData(String username, int numberOfEvents, {required bool isAdmin, required bool isSubscribed}) async{
    return usersCollection.doc(uid).set({
      'username': username,
      'isAdmin' : isAdmin,
      'isSubscrbed' : isSubscribed,
      'numberOfEvents' : numberOfEvents,
    });
  }

  Future<String> changePosterAndGetUrl(String url, File f) async{
    final Reference _firebaseStorageReference = FirebaseStorage.instance.refFromURL(url);
    await _firebaseStorageReference.putFile(f);
    return _firebaseStorageReference.getDownloadURL();
  }

  Future<String> uploadPosterAndGetUrl(File f) async{
    late int numberOfEvents;
    late String res;
    return usersCollection.doc(uid).get().then((doc) async{
      numberOfEvents = int.parse(doc.get('numberOfEvents').toString());
      final Reference _firebaseStorageReference = FirebaseStorage.instance.ref().child(
        '$uid$numberOfEvents.jpg',
      );
      await _firebaseStorageReference.putFile(f);
      res = await FirebaseStorage.instance.ref().child('$uid$numberOfEvents.jpg').getDownloadURL();
      return usersCollection.doc(uid).get().then((doc) async{
        await doc.reference.update({
          'numberOfEvents' : numberOfEvents + 1
        });
        return res;
      });
    });
  }

  Future createEvent(String name, String description, String city, String location, Timestamp when,Timestamp created, File poster)async {
    final String posterUrl = await uploadPosterAndGetUrl(poster);
    await eventsCollection.add(
      {
        'name' : name,
        'description' : description,
        'posterUrl' : posterUrl,
        'city' : city,
        'location' : location,
        'when' : when,
        'created' : created,
        'author' : uid,
      }
    );
  }

  Future addSaved(String eventUid)async {
    if(await isSaved(eventUid)){
      removeSaved(eventUid);
    }
    else{
      savedCollection.add(
        {
          'event' : eventUid,
          'user' : uid,
        }
      );
    }
  }

  Future removeSaved(String eventUid) async {
    final res = await savedCollection.where('event', isEqualTo: eventUid).where('user', isEqualTo: uid).get();
    try{
      return res.docs[0].reference.delete();
    }catch(e){
      return;
    }
  }

  Future deleteEvent(String eventUid) async {
    final res = await eventsCollection.doc(eventUid).get();
    try{
      return res.reference.delete();
    }catch(e){
      return;
    }
  }

  Future updateEvent(String authorUid, String name, String description, String city, String location, Timestamp when, String posterUrl)async {
    await eventsCollection.doc(uid).update(
      {
        'name' : name,
        'description' : description,
        'posterUrl' : posterUrl,
        'city' : city,
        'location' : location,
        'when' : when,
        'author' : authorUid,
      }
    );
  }

  Future<bool> isSaved(String eventUid) async{
    final res = await savedCollection.where('event', isEqualTo: eventUid).where('user', isEqualTo: uid).get();
    return res.docs.isNotEmpty;
  }

  Future<List<String>> getLazyCategoryEventsUids(String? city, String category){
    final List<String> list = [];
    return eventsCollection.orderBy('when', descending: true).get().then((snap){
      for(final doc in snap.docs){
        if(list.length<30){
          if(city==null && eventIsNotFinished(doc.get('when') as Timestamp) && doc.get('category').toString() == category){
            list.add(doc.id);
          } else if(city != null && doc.get('city').toString() == city && eventIsNotFinished(doc.get('when') as Timestamp) && doc.get('category').toString() == category){
            list.add(doc.id);
          } else if(city != null && doc.get('city').toString() == city && eventIsNotFinished(doc.get('when') as Timestamp) && doc.get('category').toString() == category){
              list.add(doc.id);
          }
        } else {
          break;
        }
      }
      return list;
    });
  }

  Future<List<String>> getLazyCategoryEventsUidNext(String last, String? city, String category) async{
    final List<String> list = [];
    final lastVisible = await eventsCollection.doc(last).get();
    return eventsCollection.orderBy('when', descending: true).startAfterDocument(lastVisible).get().then((snap){
      for(final doc in snap.docs){
        if(list.length<30){
          if(city==null && eventIsNotFinished(doc.get('when') as Timestamp) && doc.get('category').toString() == category){
              list.add(doc.id);
          } else if(city != null && doc.get('city').toString() == city && eventIsNotFinished(doc.get('when') as Timestamp) && doc.get('category').toString() == category){
              list.add(doc.id);
          } else if(city != null && doc.get('city').toString() == city && eventIsNotFinished(doc.get('when') as Timestamp) && doc.get('category').toString() == category){
            list.add(doc.id);
          }
        } else {
          break;
        }
      }
      return list;
    });
  }

  Future<List<String>> getLazyLocalFutureEventsUids(String local){
    final List<String> list = [];
    return eventsCollection.orderBy('when', descending: true).get().then((snap){
      for(final doc in snap.docs){
        if(list.length<10){
          if(eventIsNotFinished(doc.get('when') as Timestamp) && doc.get('author').toString() == local){
            list.add(doc.id);
          } else if(eventIsNotFinished(doc.get('when') as Timestamp) && doc.get('author').toString() == local){
            list.add(doc.id);
          } else if(eventIsNotFinished(doc.get('when') as Timestamp) && doc.get('author').toString() == local){
              list.add(doc.id);
          }
        } else {
          break;
        }
      }
      return list;
    });
  }

  Future<List<String>> getLazyLocalPastEventsUids(String local){
    final List<String> list = [];
    return eventsCollection.orderBy('when', descending: true).get().then((snap){
      for(final doc in snap.docs){
        if(list.length<10){
          if(!eventIsNotFinished(doc.get('when') as Timestamp) && doc.get('author').toString() == local){
            list.add(doc.id);
          } else if(!eventIsNotFinished(doc.get('when') as Timestamp) && doc.get('author').toString() == local){
            list.add(doc.id);
          } else if(!eventIsNotFinished(doc.get('when') as Timestamp) && doc.get('author').toString() == local){
              list.add(doc.id);
          }
        } else {
          break;
        }
      }
      return list;
    });
  }

  bool eventIsNotFinished(Timestamp eventDate){
    return eventDate.toDate().compareTo(Timestamp.now().toDate()) > 0;
  }

  Future<String> getLocationName(String author) async{
    final doc = await usersCollection.doc(author).snapshots().first;
    return doc.get('username').toString();
  }

  Future<String> getUsername(String user) async{
    final doc = await usersCollection.doc(user).snapshots().first;
    return doc.get('username').toString();
  }

  Future<String> generateRandomEvent() async {
    final _random = Random();
    List <String> events = [];
    events = await eventsCollection.get().then((value){
      final List <String> eventsAdded = [];
      for(final doc in value.docs){
        if(eventIsNotFinished(doc.get('when') as Timestamp)){
          eventsAdded.add(doc.id);
        }
      }
      return eventsAdded;
    });
    final int next = _random.nextInt(events.length);
    return events[next];
  }

  Future<bool> userAlredyExists(String userUid) async{
    final doc = await usersCollection.doc(userUid).get();
    return doc.exists;
  }
}
