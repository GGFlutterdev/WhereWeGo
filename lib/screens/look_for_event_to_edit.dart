import 'package:flutter/material.dart';
import 'package:uni_events/components/my_app_bar.dart';

class LookForEventToEdit extends StatelessWidget {
  const LookForEventToEdit({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyAppBar(
        title: 'Modifica evento',
        home: false,
        showInfo: false,
      ),
    );
  }
}
