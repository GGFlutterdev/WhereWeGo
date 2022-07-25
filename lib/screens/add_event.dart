import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_events/components/add_event_fields.dart';
import 'package:uni_events/schedule/add_event_schedule.dart';

class AddEvent extends StatelessWidget {
  const AddEvent({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ChangeNotifierProvider.value(
            value: AddEventSchedule(),
            child: const AddEventFields(),
          ),
        ),
      ),
    );
  }
}
