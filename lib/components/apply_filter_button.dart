import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_events/schedule/home_schedule.dart';
import 'package:uni_events/services/demolocalizations.dart';

class ApplyFilterButton extends StatelessWidget {
  const ApplyFilterButton({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _homeSchedule = Provider.of<HomeSchedule>(context);
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Theme.of(context).appBarTheme.backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(23.0),
          ),
      ),
      onPressed: (){
        _homeSchedule.applyFilters();
        Navigator.pop(context);
      },
      child: SizedBox(
        height: 60,
        child: Center(
          child: Text(
            DemoLocalizations.of(context)!.trans('Filtra')!,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
          ),
        ),
      ),
    );
  }
}
