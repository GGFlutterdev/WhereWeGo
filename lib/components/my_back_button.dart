import 'package:flutter/material.dart';
import 'package:uni_events/constants.dart';

class MyBackButton extends StatelessWidget {
  const MyBackButton({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          decoration: const BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.all(
              Radius.circular(100),
            ),
          ),
          width: 50,
          height: 50,
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back,
            ),
          ),
        )
      ],
    );
  }
}
