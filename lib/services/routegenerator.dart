import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_events/components/my_bottom_nav_bar.dart';
import 'package:uni_events/models/event.dart';
import 'package:uni_events/schedule/add_event_schedule.dart';
import 'package:uni_events/schedule/category_schedule.dart';
import 'package:uni_events/schedule/edit_event_schedule.dart';
import 'package:uni_events/schedule/reset_password_schedule.dart';
import 'package:uni_events/schedule/saved_events_schedule.dart';
import 'package:uni_events/schedule/sign_in_schedule.dart';
import 'package:uni_events/schedule/your_events_schedule.dart';
import 'package:uni_events/screens/add_event.dart';
import 'package:uni_events/screens/edit_event_page.dart';
import 'package:uni_events/screens/event_page.dart';
import 'package:uni_events/screens/events_for_category.dart';
import 'package:uni_events/screens/loading_page.dart';
import 'package:uni_events/screens/personal_area.dart';
import 'package:uni_events/screens/reset_password.dart';
import 'package:uni_events/screens/saved_events.dart';
import 'package:uni_events/screens/sign_in/sign_in_wrapper.dart';
import 'package:uni_events/screens/your_events_page.dart';
import 'package:uni_events/services/database.dart';

Route<dynamic> generateRoute(RouteSettings settings){
  final arguments = settings.arguments;
  switch (settings.name){
    case '/' : 
      return MaterialPageRoute(builder: (_) => const MyBottomNavBar());
    case '/signin' :
      return MaterialPageRoute(
        builder: (_) => ChangeNotifierProvider(
        create: (BuildContext context) => SignInSchedule(),
        child: const SignInWrapper(),
        ),
      );
    case '/resetPassword' :
      return MaterialPageRoute(
        builder: (_) => ChangeNotifierProvider(
        create: (BuildContext context) => ResetPasswordSchedule(),
        child: const ResetPassword(),
        ),
      );
    case '/settings' :
      return MaterialPageRoute(builder: (_) => const PersonalArea());
    case '/addEvent' :
      return MaterialPageRoute(
        builder: (_) => ChangeNotifierProvider(
        create: (BuildContext context) => AddEventSchedule(),
        child: const AddEvent(),
        ),
      );
    
    case '/savedEvents' :
      if(arguments is String){
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider.value(
            value: SavedEventsSchedule.initialize(arguments),
            child: const SavedEvents(),
          ),
        );
      }else{
        return MaterialPageRoute(builder: (_) => const MyBottomNavBar());
      }
    case '/yourEvents' :
      if(arguments is String){
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider.value(
            value: YourEventsSchedule.initialize(arguments),
            child: const YourEventsPage(),
          ),
        );
      }else{
        return MaterialPageRoute(builder: (_) => const MyBottomNavBar());
      }
    case '/eventDetails' :
      if(arguments is String){
        return MaterialPageRoute(
          builder: (context) => EventPage(
            uid: arguments,
          ),
        );
      }else{
        return MaterialPageRoute(builder: (_) => const MyBottomNavBar());
      }
    case '/category' : 
      if(arguments is String){
        return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider.value(
            value: CategorySchedule.initialize(arguments),
            child: EventsForCategory(
              category: arguments,
            ),
          ),
        );
      }else{
        return MaterialPageRoute(builder: (_) => const MyBottomNavBar());
      }
    default :
      return MaterialPageRoute(builder: (_) => const MyBottomNavBar());
  }
}
