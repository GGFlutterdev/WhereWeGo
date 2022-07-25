import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:uni_events/constants.dart';
import 'package:uni_events/screens/add_event.dart';
import 'package:uni_events/services/demolocalizations.dart';

class AddEventButton extends StatelessWidget {
  const AddEventButton({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Theme.of(context).appBarTheme.backgroundColor,
      ),
      onPressed: () => pushNewScreen(context, screen: const AddEvent()),
      child: SizedBox(
        height: buttonHeight,
        width: MediaQuery.of(context).size.width*0.75,
        child: Center(
          child: Text(
            DemoLocalizations.of(context)!.trans('Aggiungi evento')!,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      ),
    );
  }
}
