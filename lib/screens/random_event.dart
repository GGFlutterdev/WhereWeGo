import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_events/components/event_generated.dart';
import 'package:uni_events/components/no_event_generated.dart';
import 'package:uni_events/schedule/random_event_schedule.dart';

class RandomEvent extends StatelessWidget {
  const RandomEvent({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _schedule = Provider.of<RandomEventSchedule>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: _schedule.event == null ? const NoEventGenerated() : const EventGenerated(),
        ),
      ),
    );
  }
}
