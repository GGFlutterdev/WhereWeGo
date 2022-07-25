import 'package:flutter/material.dart';
import 'package:uni_events/components/sample_propic.dart';
import 'package:uni_events/services/demolocalizations.dart';

class SignInButtonBody extends StatelessWidget {
  const SignInButtonBody({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 8,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 0.5,
            color: Theme.of(context).appBarTheme.backgroundColor!,
          ),
          top: BorderSide(
            width: 0.5,
            color: Theme.of(context).appBarTheme.backgroundColor!,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              const SamplePropic(),
              const SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    DemoLocalizations.of(context)!.trans("Accedi")!,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Text(
                    DemoLocalizations.of(context)!.trans("Salva gli eventi e molto altro")!,
                    style: Theme.of(context).textTheme.caption!.copyWith(
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            ],
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: Theme.of(context).textTheme.bodyText1!.color,
          )
        ],
      ),
    );
  }
}
