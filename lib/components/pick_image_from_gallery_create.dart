import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_events/constants.dart';
import 'package:uni_events/schedule/add_event_schedule.dart';
import 'package:uni_events/services/demolocalizations.dart';

class PickImageFromGalleryCreate extends StatelessWidget {
  const PickImageFromGalleryCreate({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _addSchedule = Provider.of<AddEventSchedule>(context);
    return InkResponse(
      onTap: () => _addSchedule.pickImageFromGallery(),
      child: Container(
        height: eventPosterHeight,
        decoration: BoxDecoration(
          border: Border.all(
            color: kPrimaryColor,
          ),
        ),
        child: _addSchedule.poster == null ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.add_photo_alternate,
                color: Theme.of(context).appBarTheme.backgroundColor,
                size: 100,
              ),
              Text(
                DemoLocalizations.of(context)!.trans('Inserisci la locandina')!,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: Theme.of(context).appBarTheme.backgroundColor,
                ),
              )
            ],
          ),
        ) : Image.file(
          _addSchedule.poster!,
        ),
      ),
    );
  }
}
