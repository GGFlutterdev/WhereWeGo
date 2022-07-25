import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_events/schedule/sign_in_schedule.dart';
import 'package:uni_events/screens/sign_in/register_page.dart';
import 'package:uni_events/screens/sign_in/sign_in_page.dart';

class SignInWrapper extends StatelessWidget {
  const SignInWrapper({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _signInProvider = Provider.of<SignInSchedule>(context);
    return Scaffold(
      body: _signInProvider.showSignIn ? const SignInPage() : const RegisterPage(),
    );
  }
}
