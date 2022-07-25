import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_events/constants.dart';
import 'package:uni_events/schedule/edit_event_schedule.dart';

class PickImageFromGalleryEdit extends StatelessWidget {
  const PickImageFromGalleryEdit({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _editSchedule = Provider.of<EditEventSchedule>(context);
    return InkResponse(
      onTap: () => _editSchedule.pickImageFromGallery(),
      child: Container(
        height: eventPosterHeight,
        decoration: BoxDecoration(
          border: Border.all(
            color: kPrimaryColor,
          ),
        ),
        child: _editSchedule.poster == null ? Image.network(
          _editSchedule.posterUrl,
        ): Image.file(
          _editSchedule.poster!,
        ),
      ),
    );
  }
}
