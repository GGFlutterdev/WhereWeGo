import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_events/components/saved_events_list.dart';
import 'package:uni_events/schedule/saved_events_schedule.dart';

class SavedEvents extends StatelessWidget {
  const SavedEvents({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<String?>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ChangeNotifierProvider.value(
            value: SavedEventsSchedule.initialize(_user!),
            child: const SavedEventsList(),
          ),
        ),
      ),
    );
  }
}
