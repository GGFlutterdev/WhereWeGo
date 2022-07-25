import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:uni_events/constants.dart';
import 'package:uni_events/screens/random_event.dart';

class GoToRandomEvent extends StatelessWidget {
  const GoToRandomEvent({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      splashFactory: NoSplash.splashFactory,
      onTap: () => pushNewScreen(
        context,
        screen: const RandomEvent(),
        withNavBar: true, // OPTIONAL VALUE. True by default.
        pageTransitionAnimation: PageTransitionAnimation.cupertino,
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        width: 300,
        height: 80,
        margin: const EdgeInsets.only(
          bottom: 20,
        ),
        child: Center(
          child: Text(
            'Non lo so, per me è uguale',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      ),
    );
  }
}
