import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:uni_events/components/preview_poster_loading.dart';
import 'package:uni_events/constants.dart';
import 'package:uni_events/models/event.dart';
import 'package:uni_events/screens/event_page.dart';

class LocalEvent extends StatelessWidget {
  const LocalEvent({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _event = Provider.of<Event?>(context);
    return _event == null ? const SizedBox() : Container(
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 10,
      ),
      child: Stack(
        children: <Widget>[
          CachedNetworkImage(
            imageUrl: _event.posterUrl,
            placeholder: (context, url) => const ImageLoading(
              w: 150,
              h: 180,
            ),
            imageBuilder: (context, imageProvider) => Image(
              width: 150,
              height: 180,
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 50,
            left: 5,
            child: Container(
              decoration: const BoxDecoration(
                color: kPrimaryColor,
              ),
              width: 130,
              height: 45,
              child: Container(
                padding: const EdgeInsets.only(
                  left: 8,
                ),
                child: Text(
                  _event.name,
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 5,
            left: 5,
            child: InkResponse(
              onTap: () => pushNewScreen(context, screen: EventPage(uid: _event.uid)),
              child: Container(
                decoration: const BoxDecoration(
                  color: kPrimaryColor,
                ),
                width: 75,
                height: 35,
                child: Center(
                  child: Text(
                    'Info',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}