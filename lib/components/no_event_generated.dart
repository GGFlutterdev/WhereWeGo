import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_events/constants.dart';
import 'package:uni_events/schedule/random_event_schedule.dart';

class NoEventGenerated extends StatelessWidget {
  const NoEventGenerated({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _schedule = Provider.of<RandomEventSchedule>(context);
    return Center(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Non sai cosa fare?',
                  style: Theme.of(context).textTheme.headline1,
                ),
                const SizedBox(
                  height: 50,
                ),
                Text(
                  'Ci pensiamo noi!',
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                    color: kPrimaryColor,
                  ),
                ),
              ],
            ),
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
                  'Genera un evento casuale',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
