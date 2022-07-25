import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:uni_events/components/events_coming.dart';
import 'package:uni_events/components/my_back_button.dart';
import 'package:uni_events/components/past_events.dart';
import 'package:uni_events/components/preview_poster_loading.dart';
import 'package:uni_events/constants.dart';
import 'package:uni_events/models/my_user.dart';
import 'package:uni_events/services/database.dart';

class LocalPage extends StatelessWidget {
  final String local;
  const LocalPage({ Key? key, required this.local }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MyUser>(
      stream: Database(uid: local).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: ListView(
                  children: <Widget>[
                    const MyBackButton(),
                    Center(
                      child: FutureBuilder<String?>(
                        future: Database().getLocationName(local),
                        builder: (context, snap){
                          if(snap.hasData){
                            return Text(
                              snap.data ?? '',
                              style: Theme.of(context).textTheme.headline1,
                              overflow: TextOverflow.ellipsis,
                            );
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: CachedNetworkImage(
                        imageUrl: snapshot.data!.propic!,
                        placeholder: (context, url) => const ImageLoading(
                          w: 100,
                          h: 100,
                        ),
                        imageBuilder: (context, imageProvider) => SizedBox(
                          height: 120,
                          width: 120,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(100),
                            ),
                            child: Image(
                              fit: BoxFit.cover,
                              image: imageProvider,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: Container(
                        decoration: const BoxDecoration(
                          color: kPrimaryColor,
                        ),
                        height: 40,
                        width: 150,
                        child: Center(
                          child: Text(
                            'Segui',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Text(
                      'Eventi in arrivo',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    EventsComing(
                      user: snapshot.data!.uid,
                    ),
                    Text(
                      'Eventi passati',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    PastEvents(
                      user: snapshot.data!.uid,
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
