import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_events/components/big_event_preview.dart';
import 'package:uni_events/constants.dart';
import 'package:uni_events/schedule/random_event_schedule.dart';

class EventGenerated extends StatelessWidget {
  const EventGenerated({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _schedule = Provider.of<RandomEventSchedule>(context);
    return Column(
      children: <Widget>[
        Text(
          'Per te abbiamo scelto...',
          style: Theme.of(context).textTheme.headline1,
        ),
        BigEventPreview(event: _schedule.event!),
        const Expanded(
          child: SizedBox(),
        ),
        InkResponse(
          onTap: () => _schedule.generateEvent(),
          child: Container(
            decoration: const BoxDecoration(
              color: kPrimaryColor,
            ),
            height: 60,
            width: MediaQuery.of(context).size.width-60,
            child: Center(
              child: Text(
                'Genera un altro evento',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ),
        )
      ],
    );
  }
}
