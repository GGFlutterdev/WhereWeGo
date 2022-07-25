import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:uni_events/components/preview_poster_loading.dart';
import 'package:uni_events/constants.dart';
import 'package:uni_events/models/event.dart';
import 'package:uni_events/screens/event_page.dart';
import 'package:uni_events/screens/local_page.dart';
import 'package:uni_events/services/database.dart';

class BigEventPreview extends StatelessWidget {
  final String event;
  const BigEventPreview({ Key? key, required this.event }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: Database(uid: event).eventData,
      catchError: (context, event){},
      initialData: null,
      child: Consumer<Event?>(
        builder: (context, schedule, _) => schedule != null ? 
          Stack(
            children: <Widget>[
              
              CachedNetworkImage(
                imageUrl: schedule.posterUrl,
                placeholder: (context, url) => const ImageLoading(
                  w: 289,
                  h: 439,
                ),
                imageBuilder: (context, imageProvider) => Image(
                  height: 439,
                  image: imageProvider,
                ),
              ),
              Positioned(
                left: 10,
                bottom: 10,
                child: InkResponse(
                  onTap: () => pushNewScreen(
                    context,
                    screen: EventPage(uid: event),
                  ),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: kPrimaryColor,
                    ),
                    height: 40,
                    width: 120,
                    child: Center(
                      child: Text(
                        'Info',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 10,
                bottom: 110,
                child: Container(
                  decoration: const BoxDecoration(
                    color: kPrimaryColor,
                  ),
                  height: 40,
                  width: MediaQuery.of(context).size.width-150,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                        ),
                        child: Text(
                          schedule.name,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 10,
                bottom: 60,
                child: InkResponse(
                  onTap: () => pushNewScreen(context, screen: LocalPage(local: schedule.author)),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: kPrimaryColor,
                    ),
                    height: 40,
                    width: MediaQuery.of(context).size.width-150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                          ),
                          child: FutureBuilder<String?>(
                            future: Database().getLocationName(schedule.author),
                            builder: (context, snap){
                              if(snap.hasData){
                                return Text(
                                  snap.data ?? '',
                                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: Colors.black,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                );
                              } else {
                                return const SizedBox();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ) : const SizedBox(),
      ),
    );
  }
}
