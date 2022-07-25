import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:uni_events/components/event_preview_buttons.dart';
import 'package:uni_events/components/preview_info.dart';
import 'package:uni_events/components/preview_poster.dart';
import 'package:uni_events/models/event.dart';
import 'package:uni_events/screens/event_page.dart';
import 'package:uni_events/services/database.dart';

class EventPreview extends StatelessWidget {
  const EventPreview({ Key? key, required this.uid }) : super(key: key);

  final String uid;

  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: Database(uid: uid).eventData,
      catchError: (context, event){},
      initialData: null,
      child: Consumer<Event?>(
        builder: (context, schedule, _) => schedule != null ? 
          InkResponse(
            child: Container(
              height: 108,
              margin: const EdgeInsets.only(
                top: 18,
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: InkResponse(
                      onTap: () => pushNewScreen(
                        context,
                        screen: EventPage(uid: uid),
                      ),
                      child: Row(
                        children: const <Widget>[
                          PreviewPoster(),
                          SizedBox(
                            width: 8,
                          ),
                          PreviewInfo(),
                          SizedBox(
                            width: 8,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const EventPreviewButtons()
                ],
              ),
            ),
          ) : const SizedBox(),
      ),
    );
  }
}
