import 'package:flutter/material.dart';
import 'package:uni_events/components/sign_in_button_body.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({ Key? key,}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: () => Navigator.pushNamed(context, '/signin'),
      child: const SignInButtonBody(),
    );
  }
}
