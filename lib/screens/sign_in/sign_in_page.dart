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

class SignInPage extends StatefulWidget {
  const SignInPage({ Key? key }) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final _signInSchedule = Provider.of<SignInSchedule>(context);
    return Scaffold(
      appBar: MyAppBar(
        title: DemoLocalizations.of(context)!.trans('Accedi')!,
        home: false,
        showInfo: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 16,
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
                      Row(
                        children: <Widget>[
                          CupertinoButton(
                            onPressed: () => Navigator.pushNamed(context, '/resetPassword'),
                            child: Text(
                              '${DemoLocalizations.of(context)!.trans('Password dimenticata')!}?',
                              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                color: Theme.of(context).appBarTheme.backgroundColor,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              CupertinoButton(
                onPressed: () => _signInSchedule.toggleShowSignIn(),
                child: RichText(
                  text: TextSpan(
                    text: '${DemoLocalizations.of(context)!.trans('Non hai un account')!}? ',
                    style: Theme.of(context).textTheme.bodyText2,
                    children: <TextSpan>[
                      TextSpan(
                        text: DemoLocalizations.of(context)!.trans('Registrati'),
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
                onPressed: !_signInSchedule.clickableSignIn() ? null : () async{
                  final res = await Auth().signInWithEmailAndPassword(_signInSchedule.email, _signInSchedule.password).catchError(
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
                      DemoLocalizations.of(context)!.trans('Accedi')!,
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
