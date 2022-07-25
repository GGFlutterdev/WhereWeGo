import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:uni_events/constants.dart';
import 'package:uni_events/screens/your_events_page.dart';

class YourEventsButton extends StatelessWidget {
  const YourEventsButton({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<String?>(context);
    return _user == null ? const SizedBox() : ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Theme.of(context).appBarTheme.backgroundColor,
      ),
      onPressed: () => pushNewScreen(context, screen: const YourEventsPage()),
      child: SizedBox(
        height: buttonHeight,
        width: MediaQuery.of(context).size.width*0.75,
        child: Center(
          child: Text(
            'I tuoi eventi',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      ),
    );
  }
}
