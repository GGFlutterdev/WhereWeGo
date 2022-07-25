import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:uni_events/components/my_back_button.dart';
import 'package:uni_events/components/preview_poster_loading.dart';
import 'package:uni_events/constants.dart';
import 'package:uni_events/models/event.dart';
import 'package:uni_events/screens/loading_page.dart';
import 'package:uni_events/screens/local_page.dart';
import 'package:uni_events/services/database.dart';

class EventPage extends StatelessWidget {
  const EventPage({ Key? key, required this.uid }) : super(key: key);

  final String uid;

  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: Database(uid: uid).eventData,
      catchError: (context, event){},
      initialData: null,
      child: Consumer<Event?>(
        builder: (context, schedule, _) => schedule != null ? Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: ListView(
                      children: <Widget>[
                        const MyBackButton(),
                        const SizedBox(
                          height: 12,
                        ),
                        CachedNetworkImage(
                          imageUrl: schedule.posterUrl,
                          placeholder: (context, url) => const ImageLoading(
                            w: 224,
                            h: 264,
                          ),
                          imageBuilder: (context, imageProvider) => Image(
                            width: 224,
                            height: 264,
                            image: imageProvider,
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Center(
                          child: Text(
                            schedule.name,
                            style: Theme.of(context).textTheme.headline1!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        InkResponse(
                          onTap: () => pushNewScreen(context, screen: LocalPage(local: schedule.author)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const Icon(
                                Icons.location_pin,
                                color: kPrimaryColor,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              FutureBuilder<String?>(
                                future: Database().getLocationName(schedule.author),
                                builder: (context, snap){
                                  if(snap.hasData){
                                    return Text(
                                      snap.data ?? '',
                                      style: Theme.of(context).textTheme.bodyText1,
                                      overflow: TextOverflow.ellipsis,
                                    );
                                  } else {
                                    return const SizedBox();
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Icon(
                              Icons.calendar_today,
                              color: kPrimaryColor,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              '${schedule.when.toDate().day}/${schedule.when.toDate().month}/${schedule.when.toDate().year}',
                              style: Theme.of(context).textTheme.bodyText1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Icon(
                              Icons.alarm,
                              color: kPrimaryColor,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              '${schedule.when.toDate().hour}:${schedule.when.toDate().minute}',
                              style: Theme.of(context).textTheme.bodyText1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          schedule.description,
                          style: Theme.of(context).textTheme.bodyText1,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width/1.5,
                    color: kPrimaryColor,
                    child: Center(
                      child: Text(
                        'Chiama ora',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ) : const LoadingPage(),
      ),
    );
  }
}
