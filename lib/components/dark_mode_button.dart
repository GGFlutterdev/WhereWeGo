import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_events/schedule/theming_schedule.dart';
import 'package:uni_events/services/demolocalizations.dart';

class DarkModeButton extends StatelessWidget {
  const DarkModeButton({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Container(
      padding: const EdgeInsets.all(
        8,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 0.5,
            color: Theme.of(context).appBarTheme.backgroundColor!,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            DemoLocalizations.of(context)!.trans("Modalità scura")!,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Consumer<ThemingSchedule>(
            builder: (context, schedule, _) => FutureBuilder(
              future: ThemingSchedule.currentTheme,
              builder: (BuildContext context, AsyncSnapshot<ThemeMode> snapshot) => Platform.isAndroid ? Switch(
                value: snapshot.data ==ThemeMode.dark,
                onChanged:(boolean)=> schedule.toggleTheme(),
                inactiveTrackColor: Colors.black,
              ) :
              CupertinoSwitch(
                value: snapshot.data ==ThemeMode.dark,
                onChanged:(boolean)=> schedule.toggleTheme(),
                trackColor: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
