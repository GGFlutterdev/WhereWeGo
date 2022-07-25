import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uni_events/constants.dart';
import 'package:uni_events/services/auth.dart';

class ChooseSignIn extends StatelessWidget {
  const ChooseSignIn({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<String?>(context);
    return _user != null ? const SizedBox() : Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Accedi con',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  decoration: const BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(100),
                    ),
                  ),
                  width: 60,
                  height: 60,
                  child: const Icon(
                    Icons.apple,
                    size: 40,
                  ),
                ),
                InkResponse(
                  onTap: () => Auth().signinWithGoogle(),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(100),
                      ),
                    ),
                    width: 60,
                    height: 60,
                    child: const Icon(
                      FontAwesomeIcons.google,
                      size: 35,
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(100),
                    ),
                  ),
                  width: 60,
                  height: 60,
                  child: const Icon(
                    Icons.facebook,
                    size: 40,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Per salvarti i tuoi eventi preferiti',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      ),
    );
  }
}
