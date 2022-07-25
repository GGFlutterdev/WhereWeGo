import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_events/components/data_search.dart';
import 'package:uni_events/functions.dart';
import 'package:uni_events/schedule/home_schedule.dart';
import 'package:uni_events/services/demolocalizations.dart';

class MainCity extends StatelessWidget {
  const MainCity({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _homeSchedule = Provider.of<HomeSchedule>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          'La tua città',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        Expanded(
          child: FutureBuilder<String?>(
            future: getMainCity(),
            builder: (context, snap){
              if(snap.hasData && snap.data != null){
                return InkWell(
                  onTap: () async {
                    final String? res= await showSearch(
                      context: context,
                      delegate: DataSearch(
                        cities: _homeSchedule.cities,
                      ),
                      useRootNavigator: true,
                    );
                    if(res != null && res != ''){
                      _homeSchedule.city = res;
                      setMainCity(res);
                      _homeSchedule.loadEvents();
                    }
                  },
                  child: Text(
                    snap.data!,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: Theme.of(context).appBarTheme.backgroundColor,
                    ),
                    textAlign: TextAlign.right,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              } else {
                return InkWell(
                  onTap: () async {
                    final String? res= await showSearch(
                      context: context,
                      delegate: DataSearch(
                        cities: _homeSchedule.cities,
                      ),
                      useRootNavigator: true,
                    );
                    if(res != null && res != ''){
                      _homeSchedule.city = res;
                      setMainCity(res);
                      _homeSchedule.loadEvents();
                    }
                  },
                  child: Text(
                    DemoLocalizations.of(context)!.trans('Seleziona città')!,
                    textAlign: TextAlign.right,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: Theme.of(context).appBarTheme.backgroundColor,
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
