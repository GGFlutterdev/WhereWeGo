import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uni_events/constants.dart';

import 'package:uni_events/models/event.dart';
import 'package:uni_events/services/database.dart';

class FavouriteButton extends StatefulWidget {
  const FavouriteButton({ Key? key }) : super(key: key);

  @override
  _FavouriteButtonState createState() => _FavouriteButtonState();
}

class _FavouriteButtonState extends State<FavouriteButton> {
  
  @override
  Widget build(BuildContext context) {
    final _event = Provider.of<Event?>(context);
    final _user = Provider.of<String?>(context);
    if(_event != null){
      return FutureBuilder<bool>(
        future: Database(uid: _user).isSaved(_event.uid),
        builder: (context, snapshot) {
          if(snapshot.hasData && snapshot.connectionState == ConnectionState.done){
            return InkResponse(
              onTap: () async {
                await Database(uid: _user).addSaved(_event.uid);
                await Database(uid: _user).isSaved(_event.uid);
                setState(() {
                  
                });
              },
              child: Container(
                decoration: const BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(100),
                  ),
                ),
                width: 30,
                height: 30,
                child: Icon(
                  snapshot.data! ? Icons.favorite : Icons.favorite_border,
                  color: snapshot.data! ? Colors.white : Colors.black,
                ),
              ),
            );
          } else {
            return Container(
              decoration: const BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(100),
                ),
              ),
              width: 30,
              height: 30,
              child: const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            );
          }
        },
      );
    } else {
      return const SizedBox(
        width: 30,
        height: 30,
      );
    }
  }
}
