
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';
import 'package:uni_events/constants.dart';
import 'package:uni_events/schedule/edit_event_schedule.dart';

class EditWhen extends StatelessWidget {
  const EditWhen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _editSchedule = Provider.of<EditEventSchedule>(context);
    return Row(
      children: <Widget>[
        Expanded(
          child: InkResponse(
            onTap: (){
              DatePicker.showDateTimePicker(
                context,
                minTime: DateTime.now(),
                maxTime: DateTime.now().add(
                  const Duration(
                    days: 365,
                  ),
                ),
                onConfirm: (date) => _editSchedule.when = Timestamp.fromDate(date),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: kPrimaryColor,
                ),
              ),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.calendar_today,
                    size: 30,
                    color: Theme.of(context).appBarTheme.backgroundColor,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Text(
                    '${_editSchedule.when!.toDate().year}/${_editSchedule.when!.toDate().month}/${_editSchedule.when!.toDate().day} - ${_editSchedule.when!.toDate().hour} : ${_editSchedule.when!.toDate().minute}',
                    style: Theme.of(context).textTheme.bodyText2,
                  )
                ],
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
          color: _editSchedule.when != null ? Colors.green : Colors.grey,
        )
      ],
    );
  }
}
