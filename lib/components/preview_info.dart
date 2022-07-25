import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_events/models/event.dart';
import 'package:uni_events/services/database.dart';

class PreviewInfo extends StatelessWidget {
  const PreviewInfo({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final event = Provider.of<Event?>(context);
    return event == null ?
      Container() : Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              event.name,
              style: Theme.of(context).textTheme.bodyText2,
              overflow: TextOverflow.ellipsis,
            ),
            FutureBuilder<String?>(
              future: Database().getLocationName(event.author),
              builder: (context, snap){
                if(snap.hasData){
                  return Text(
                    snap.data ?? '',
                    style: Theme.of(context).textTheme.bodyText2,
                    overflow: TextOverflow.ellipsis,
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
            Text(
              event.city,
              style: Theme.of(context).textTheme.bodyText2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      );
  }
}
