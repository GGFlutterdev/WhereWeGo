import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_events/components/editable_event_preview.dart';
import 'package:uni_events/components/my_back_button.dart';
import 'package:uni_events/components/show_loading.dart';
import 'package:uni_events/schedule/your_events_schedule.dart';

class YourEventsList extends StatelessWidget {
  const YourEventsList({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _yourEvents = Provider.of<YourEventsSchedule>(context);
    final _user = Provider.of<String?>(context);
    return _user == null ? const Center(
      child: ShowLoading(),
    ) : Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const MyBackButton(),
        const SizedBox(
          height: 20,
        ),
        Text(
          'I tuoi eventi',
          style: Theme.of(context).textTheme.headline2,
          textAlign: TextAlign.left,
        ),
        Expanded(
          child: NotificationListener<ScrollEndNotification>(
            onNotification: (scrollEnd){
              final metrics = scrollEnd.metrics;
              if (metrics.atEdge) {
                final bool isTop = metrics.pixels == 0;
                if (isTop) {
                } else {
                  _yourEvents.loadYourNextLazyAnnouncements(_user);
                }
              }
              return true;
            },
            child: ListView.builder(
              itemBuilder: (context, index) => EditableEventPreview(uid: _yourEvents.events[index]),
              itemCount: _yourEvents.events.length,
            ),
          ),
        ),
      ],
    );
  }
}
