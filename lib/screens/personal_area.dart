import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_events/components/choose_signin.dart';
import 'package:uni_events/components/image_profile_and_name.dart';
import 'package:uni_events/components/main_city.dart';
import 'package:uni_events/components/saved_events_button.dart';
import 'package:uni_events/components/show_admin_buttons.dart';

class PersonalArea extends StatelessWidget {
  const PersonalArea({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<String?>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget> [
              const MainCity(),
              if(_user == null) const ChooseSignIn(),
              if(_user != null)const ImageProfileAndName(),
              if(_user != null)const ShowAdminButtons(),
              if(_user != null) const SavedEventsButton(),
            ],
          ),
        ),
      ),
    );
  }
}
