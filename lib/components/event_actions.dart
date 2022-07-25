import 'package:flutter/material.dart';
import 'package:uni_events/components/save_button.dart';
import 'package:uni_events/components/take_me_here_button.dart';

class EventActions extends StatelessWidget {
  const EventActions({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const <Widget>[
        SaveButton(),
        SizedBox(
          width: 8,
        ),
        TakeMeHereButton()
      ],
    );
  }
}
