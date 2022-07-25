import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_events/components/my_app_bar.dart';
import 'package:uni_events/components/my_form_field_with_validator.dart';
import 'package:uni_events/components/sign_in_error_message.dart';
import 'package:uni_events/schedule/reset_password_schedule.dart';
import 'package:uni_events/services/auth.dart';
import 'package:uni_events/services/demolocalizations.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _resetPassword = Provider.of<ResetPasswordSchedule>(context);
    return Scaffold(
      appBar: MyAppBar(
        title: DemoLocalizations.of(context)!.trans('Reimposta password')!,
        home: false,
        showInfo: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const  EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          child: Form(
            child: Column(
              children: <Widget>[
                MyFormFieldWithValidator(
                  inputAction: TextInputAction.done,
                  inputType: TextInputType.emailAddress,
                  labelText: 'Email',
                  obscured: false,
                  isValidValue: _resetPassword.validateEmail(),
                  onChanged: (val) => _resetPassword.email = val.toString(),
                  initialValue: _resetPassword.email,
                ),
                const Expanded(
                  child: SizedBox(),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).appBarTheme.backgroundColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(23.0),
                      ),
                  ),
                  onPressed: !_resetPassword.validateEmail() ? null : (){
                    Auth().resetPassword(_resetPassword.email);
                    showModalBottomSheet(
                      context: context, builder: (context) => const SignInErrorMessage(e: 'Email successfully sent'),
                    );
                  },
                  child: SizedBox(
                    height: 60,
                    child: Center(
                      child: Text(
                        DemoLocalizations.of(context)!.trans('Invia email per cambiare la password')!,
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
      ),
    );
  }
}
