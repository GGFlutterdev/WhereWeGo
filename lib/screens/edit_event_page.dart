import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_events/components/edit_event_fields.dart';
import 'package:uni_events/components/my_back_button.dart';
import 'package:uni_events/components/pick_image_from_gallery_edit.dart';
import 'package:uni_events/models/event.dart';
import 'package:uni_events/schedule/edit_event_schedule.dart';

class EditEventPage extends StatelessWidget {
  final Event event;
  const EditEventPage({ Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ChangeNotifierProvider.value(
            value: EditEventSchedule(
              name: event.name,
              when: event.when,
              description: event.description,
              location: event.location,
              posterUrl: event.posterUrl,
              uid: event.uid,
              city: event.city,
            ),
            child: ListView(
              children: const <Widget>[
                MyBackButton(),
                SizedBox(
                  height: 20,
                ),
                PickImageFromGalleryEdit(),
                EditEventFields()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
