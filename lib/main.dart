import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:uni_events/components/my_bottom_nav_bar.dart';
import 'package:uni_events/constants.dart';
import 'package:uni_events/firebase_options.dart';
import 'package:uni_events/schedule/home_schedule.dart';
import 'package:uni_events/schedule/hot_events_schedule.dart';
import 'package:uni_events/schedule/random_event_schedule.dart';
import 'package:uni_events/schedule/theming_schedule.dart';
import 'package:uni_events/services/auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp, DeviceOrientation.portraitDown
    ]
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeSchedule>(
          create: (_) => HomeSchedule.initialize(),
        ),
        ChangeNotifierProvider<HotEventsSchedule>(
          create: (_) => HotEventsSchedule.initialize(),
        ),
        ChangeNotifierProvider<RandomEventSchedule>(
          create: (_) => RandomEventSchedule(),
        ),
        ChangeNotifierProvider<ThemingSchedule >(
          create: (_) => ThemingSchedule() ,
        ),
        StreamProvider.value(
          value: Auth().user,
          catchError: (context, user){},
          initialData: null,
        ),
      ],
      child: Consumer<ThemingSchedule>(
        builder: (context, schedule, _) => FutureBuilder<ThemeMode>(
          future: ThemingSchedule.currentTheme,
          builder: (BuildContext context, AsyncSnapshot<ThemeMode> snapshot){
            return GestureDetector(
              onTap: () {
                final FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
              child: MaterialApp(
                title: 'UniEvents',
                theme: ThemingSchedule.lightTheme,
                darkTheme: ThemingSchedule.darkTheme,
                themeMode: snapshot.data,
                debugShowCheckedModeBanner: false,
                supportedLocales: supportedLocales,
                localizationsDelegates: Platform.isAndroid ? localizationsDelegates : iosLocalizationsDelegates,
                home: const MyBottomNavBar(),
              ),
            );
          },
        ),
      ),
    );
  }
}
