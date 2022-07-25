import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_events/components/hi_user.dart';
import 'package:uni_events/components/sign_in_button.dart';

class SinInOrLogged extends StatelessWidget {
  const SinInOrLogged({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<String?>(context);
    return _auth != null ? const HiUser() : const SignInButton();
  }
}
