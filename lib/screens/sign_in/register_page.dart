import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:uni_events/components/my_app_bar.dart';
import 'package:uni_events/components/my_form_field_with_validator.dart';
import 'package:uni_events/components/sign_in_error_message.dart';
import 'package:uni_events/functions.dart';
import 'package:uni_events/schedule/sign_in_schedule.dart';
import 'package:uni_events/services/auth.dart';
import 'package:uni_events/services/demolocalizations.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({ Key? key }) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final _signInSchedule = Provider.of<SignInSchedule>(context);
    return Scaffold(
      appBar: MyAppBar(
        title: DemoLocalizations.of(context)!.trans('Registrati')!,
        home: false,
        showInfo: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 16,
          ),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: <Widget>[
                      MyFormFieldWithValidator(
                        inputAction: TextInputAction.done,
                        inputType: TextInputType.emailAddress,
                        labelText: 'Email',
                        obscured: false,
                        isValidValue: _signInSchedule.validateEmail(),
                        onChanged: (val) => _signInSchedule.email = val.toString(),
                        initialValue: _signInSchedule.email,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      MyFormFieldWithValidator(
                        inputAction: TextInputAction.done,
                        inputType: TextInputType.text,
                        numberOfLines: 1,
                        labelText: 'Password',
                        obscured: true,
                        isValidValue: _signInSchedule.validatePassword(),
                        onChanged: (val) => _signInSchedule.password = val.toString(),
                        initialValue: _signInSchedule.password,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        '•Minimum 1 Upper case\n•Minimum 1 lowercase\n•Minimum 1 Numeric Number\n•Minimum 1 Special Character ( ! @ # \$ & * ~ )',
                        style: Theme.of(context).textTheme.caption,
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      MyFormFieldWithValidator(
                        inputAction: TextInputAction.done,
                        inputType: TextInputType.text,
                        labelText: 'Username',
                        obscured: false,
                        isValidValue: _signInSchedule.validateUsername(),
                        onChanged: (val) => _signInSchedule.username = val.toString(),
                        initialValue: _signInSchedule.username,
                      ),
                    ],
                  ),
                ),
              ),
              CupertinoButton(
                onPressed: () => _signInSchedule.toggleShowSignIn(),
                child: RichText(
                  text: TextSpan(
                    text: '${DemoLocalizations.of(context)!.trans('Hai già un account')!}? ',
                    style: Theme.of(context).textTheme.bodyText2,
                    children: <TextSpan>[
                      TextSpan(
                        text: DemoLocalizations.of(context)!.trans('Accedi'),
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).appBarTheme.backgroundColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).appBarTheme.backgroundColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(23.0),
                    ),
                ),
                onPressed: !_signInSchedule.clickableRegister() ? null : () async {
                  final res = await Auth().registerWithEmailAndPassword(_signInSchedule.email, _signInSchedule.password, _signInSchedule.username, isAdmin: false, isSubscribed: false).catchError(
                    (e){
                      showBottomSheet(
                        context: context, builder: (context) => SignInErrorMessage(e: makeGoodExceptions(e.toString())),
                      );
                    }
                  );
                  if(res!= null){
                    Future.delayed(
                      Duration.zero,
                      (){
                        Navigator.pop(context);
                      },
                    );
                  }
                },
                child: SizedBox(
                  height: 60,
                  child: Center(
                    child: Text(
                      DemoLocalizations.of(context)!.trans('Registrati')!,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
