import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_events/components/big_event_preview.dart';
import 'package:uni_events/schedule/hot_events_schedule.dart';

class HotEvents extends StatelessWidget {
  const HotEvents({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _schedule = Provider.of<HotEventsSchedule>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: <Widget>[
              Text(
                'Eventi hot in arrivo',
                style: Theme.of(context).textTheme.headline1,
              ),
              CarouselSlider(
                options: CarouselOptions(height: 439.0),
                items: _schedule.hotEvents.map((event) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12,
                        ),
                        child: BigEventPreview(event: event),
                      );
                    },
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
