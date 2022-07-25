import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_events/components/category_button.dart';
import 'package:uni_events/components/go_to_random_event.dart';
import 'package:uni_events/schedule/home_schedule.dart';

class Home extends StatelessWidget {
  const Home({ Key? key }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final homeSchedule = Provider.of<HomeSchedule>(context);
    return Scaffold(
      key: homeSchedule.scaffoldState,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(
            8,
          ),
          child: Center(
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Stasera ho voglia\ndi ...',
                  overflow: TextOverflow.clip,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 36,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const CategoryButton(category: 'fun'),
                const CategoryButton(category: 'relax'),
                const CategoryButton(category: 'eat'),
                const GoToRandomEvent(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
