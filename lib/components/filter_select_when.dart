
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';
import 'package:uni_events/schedule/home_schedule.dart';
import 'package:uni_events/services/demolocalizations.dart';

class FilterSelectWhen extends StatelessWidget {
  const FilterSelectWhen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _homeSchedule = Provider.of<HomeSchedule>(context);
    return Row(
      children: <Widget>[
        Expanded(
          child: InkResponse(
            onTap: (){
              DatePicker.showDatePicker(
                context,
                minTime: DateTime.now(),
                maxTime: DateTime.now().add(
                  const Duration(
                    days: 365,
                  ),
                ),
                onConfirm: (date) => _homeSchedule.when = Timestamp.fromDate(date),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(23.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    offset: const Offset(0,4),
                    blurRadius: 4,
                    color: Theme.of(context).shadowColor,
                  )
                ],
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
                  if (_homeSchedule.when != null) Text(
                    '${_homeSchedule.when!.toDate().year}-${_homeSchedule.when!.toDate().month}-${_homeSchedule.when!.toDate().day}',
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
          color: _homeSchedule.when != null ? Colors.green : Colors.grey,
        )
      ],
    );
  }
}
