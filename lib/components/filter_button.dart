import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_events/schedule/home_schedule.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({ Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _homeSchedule = Provider.of<HomeSchedule>(context);
    return SizedBox(
      width: MediaQuery.of(context).size.width/2,
      height: 40,
      child: ElevatedButton.icon(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            Theme.of(context).appBarTheme.backgroundColor!,
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(23.0),
            ),
          ),
          overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
        ),
        icon: Icon(
          Icons.filter_list,
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        label: Text(
          'Filtra',
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
        ),
        onPressed: () => _homeSchedule.scaffoldState.currentState!.openEndDrawer(),
      ),
    );
  }
}
