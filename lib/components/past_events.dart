import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_events/components/local_event.dart';
import 'package:uni_events/services/database.dart';

class PastEvents extends StatelessWidget {
  final String user;
  const PastEvents({ Key? key, required this.user }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: Database().getLazyLocalPastEventsUids(user),
      builder: (context, snap){
        if(snap.hasData && snap.connectionState == ConnectionState.done){
          if(snap.data!.isNotEmpty){
            return SizedBox(
              height: 180,
              child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => StreamProvider.value(
                value: Database(uid: snap.data![index]).eventData,
                initialData: null,
                child: const LocalEvent(),
              ),
              itemCount: snap.data!.length,
          ),
            );
          } else {
            return SizedBox(
              height: 108,
              child: Center(
                child: Text(
                  'Non ci sono eventi passati.',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            );
          }
        } else {
          return const SizedBox(
            height: 108,
          );
        }
      },
    );
  }
}
