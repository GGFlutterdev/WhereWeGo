import 'package:flutter/material.dart';
import 'package:uni_events/components/favourite_button.dart';
import 'package:uni_events/constants.dart';

class EventPreviewButtons extends StatelessWidget {
  const EventPreviewButtons({ Key? key }) : super(key: key);

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
          width: 30,
          height: 30,
          child: const Icon(
            Icons.share,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        const FavouriteButton(),
      ],
    );
  }
}
