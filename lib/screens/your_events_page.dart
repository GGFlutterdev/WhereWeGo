import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_events/components/your_events_list.dart';
import 'package:uni_events/schedule/your_events_schedule.dart';

class YourEventsPage extends StatelessWidget {
  const YourEventsPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<String?>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ChangeNotifierProvider.value(
            value: YourEventsSchedule.initialize(_user!),
            child: const YourEventsList(),
          ),
        ),
      ),
    );
  }
}
