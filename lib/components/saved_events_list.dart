import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_events/components/event_preview.dart';
import 'package:uni_events/components/my_back_button.dart';
import 'package:uni_events/components/show_loading.dart';
import 'package:uni_events/models/saved.dart';
import 'package:uni_events/schedule/saved_events_schedule.dart';
import 'package:uni_events/services/database.dart';

class SavedEventsList extends StatelessWidget {
  const SavedEventsList({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _savedEvents = Provider.of<SavedEventsSchedule>(context);
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
          'Eventi salvati',
          style: Theme.of(context).textTheme.headline2,
        ),
        Expanded(
          child: NotificationListener<ScrollEndNotification>(
            onNotification: (scrollEnd){
              final metrics = scrollEnd.metrics;
              if (metrics.atEdge) {
                final bool isTop = metrics.pixels == 0;
                if (isTop) {
                } else {
                  _savedEvents.loadNextSavedLazyAnnouncements();
                }
              }
              return true;
            },
            child: ListView.builder(
              itemBuilder: (context, index) => StreamBuilder<Saved?>(
                stream: Database(uid: _savedEvents.saved[index]).savedData,
                builder: (context, snapshot) => !snapshot.hasData ? const SizedBox() : EventPreview(
                  uid: snapshot.data!.event,
                ),
              ),
              itemCount: _savedEvents.saved.length,
            ),
          ),
        ),
      ],
    );
  }
}
