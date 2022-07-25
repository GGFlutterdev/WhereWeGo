import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_events/components/event_preview.dart';
import 'package:uni_events/components/my_back_button.dart';
import 'package:uni_events/constants.dart';
import 'package:uni_events/models/event.dart';
import 'package:uni_events/schedule/category_schedule.dart';
import 'package:uni_events/services/database.dart';

class EventsForCategory extends StatelessWidget {
  final String category;
  const EventsForCategory({ Key? key, required this.category }) : super(key: key);

  String showText(){
    if(category == 'fun') return 'divertirti';
    if(category == 'relax') return 'rilassarti';
    if(category == 'eat') return 'mangiare';
    return '';
  }

  @override
  Widget build(BuildContext context) {
    final _categoryEvents = Provider.of<CategorySchedule>(context);
    final String? _city = _categoryEvents.city;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8,),
          child: Column(
            children: <Widget>[
              const MyBackButton(),
              Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 12,
                ),
                child: RichText(
                  text: TextSpan(
                    text: 'Dove puoi ',
                    style: Theme.of(context).textTheme.headline1,
                    children: <TextSpan>[
                      TextSpan(
                        text: showText(),
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: kPrimaryColor,
                        ),
                      ),
                      if(_city != null)
                      TextSpan(
                        text: ' a ',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      if(_city != null)
                      TextSpan(
                        text: _city,
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if(_categoryEvents.events.isNotEmpty) Expanded(
                child: NotificationListener<ScrollEndNotification>(
                  onNotification: (scrollEnd){
                    final metrics = scrollEnd.metrics;
                    if (metrics.atEdge) {
                      final bool isTop = metrics.pixels == 0;
                      if (isTop) {
                      } else {
                        _categoryEvents.loadNextCategoryLazyAnnouncements();
                      }
                    }
                    return true;
                  },
                  child: ListView.builder(
                    itemBuilder: (context, index) => StreamBuilder<Event>(
                      stream: Database(uid: _categoryEvents.events[index]).eventData,
                      builder: (context, snapshot) => !snapshot.hasData ? const SizedBox() : EventPreview(
                        uid: snapshot.data!.uid,
                      ),
                    ),
                    itemCount: _categoryEvents.events.length,
                  ),
                ),
              ),
              if(_categoryEvents.events.isEmpty) Expanded(
                child: Center(
                  child: Text(
                    'Non ho trovato eventi, prova ad inserire una città vicino a te e potrai trovare eventi interessanti!',
                    style: Theme.of(context).textTheme.bodyText1,
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
