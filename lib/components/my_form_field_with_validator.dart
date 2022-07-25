import 'package:flutter/material.dart';
import 'package:uni_events/constants.dart';

class MyFormFieldWithValidator extends StatelessWidget {
  const MyFormFieldWithValidator({
    Key? key,
    required this.labelText,
    this.errText,
    required this.obscured,
    required this.isValidValue,
    required this.onChanged,
    required this.initialValue,
    this.numberOfLines,
    required this.inputType,
    required this.inputAction,
  }) : super(key: key);

  final String labelText;
  final String? errText;
  final bool obscured;
  final bool isValidValue;
  final Function onChanged;
  final String initialValue;
  final int? numberOfLines;
  final TextInputType inputType;
  final TextInputAction inputAction;
  
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              border: Border.all(
                color: kPrimaryColor,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
              child: TextFormField(
                textInputAction: inputAction,
                maxLines: numberOfLines,
                autocorrect: false,
                initialValue: initialValue,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
                    color: Theme.of(context).appBarTheme.backgroundColor,
                  ),
                  label: Text(
                    labelText,
                  ),
                  errorText: errText,
                ),
                obscureText: obscured,
                // ignore: avoid_dynamic_calls
                onChanged: (String val) => onChanged(val),
                
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        Icon(
          Icons.done,
          size: 35,
          color: isValidValue ? Colors.green : Colors.grey,
        )
      ],
    );
  }
}
