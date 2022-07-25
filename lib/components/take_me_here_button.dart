import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uni_events/models/event.dart';

class TakeMeHereButton extends StatelessWidget {

  const TakeMeHereButton({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _event = Provider.of<Event?>(context);
    return _event != null ? Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(100),
        ),
        color: Theme.of(context).cardColor,
        border: Border.all(
          color: Theme.of(context).appBarTheme.backgroundColor!,
        ),
      ),
      width: 60,
      height: 60,
      child: IconButton(
        onPressed: (){
        },
        icon: Icon(
          FontAwesomeIcons.locationArrow,
          color: Theme.of(context).appBarTheme.backgroundColor,
        ),
      ),
    ) : const SizedBox();
  }
}
