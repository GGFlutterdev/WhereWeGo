
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';
import 'package:uni_events/constants.dart';
import 'package:uni_events/schedule/add_event_schedule.dart';
import 'package:uni_events/services/demolocalizations.dart';

class SelectWhen extends StatelessWidget {
  const SelectWhen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _addSchedule = Provider.of<AddEventSchedule>(context);
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
                onConfirm: (date) => _addSchedule.when = Timestamp.fromDate(date),
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
                  if (_addSchedule.when != null) Text(
                    '${_addSchedule.when!.toDate().year}-${_addSchedule.when!.toDate().month}-${_addSchedule.when!.toDate().day} alle ${_addSchedule.when!.toDate().hour} : ${_addSchedule.when!.toDate().minute}',
                    style: Theme.of(context).textTheme.bodyText2,
                  ) else Text(
                    DemoLocalizations.of(context)!.trans('Inserisci una data')!,
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: Colors.grey,
                    ),
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
          color: _addSchedule.when != null ? Colors.green : Colors.grey,
        )
      ],
    );
  }
}
