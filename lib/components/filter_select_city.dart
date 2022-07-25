import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_events/components/data_search.dart';
import 'package:uni_events/schedule/home_schedule.dart';
import 'package:uni_events/services/demolocalizations.dart';

class FilterSelectCity extends StatelessWidget {
  const FilterSelectCity({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _homeSchedule = Provider.of<HomeSchedule>(context);

    return Row(
      children: <Widget>[
        Expanded(
          child: InkResponse(
            onTap: () async {
              final String? res= await showSearch(
                context: context,
                delegate: DataSearch(
                  cities: _homeSchedule.cities,
                ),
                useRootNavigator: true,
              );
              if(res != null && res != '') _homeSchedule.city = res;
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 16,
              ),
              height: 65,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(
                    23,
                  ),
                ),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    offset: const Offset(0,4),
                    blurRadius: 4,
                    color: Theme.of(context).shadowColor,
                  )
                ],
                color: Theme.of(context).cardColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        DemoLocalizations.of(context)!.trans('Città')!,
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: Theme.of(context).appBarTheme.backgroundColor,
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      if(_homeSchedule.city != null)
                        Expanded(
                          child: Text(
                            _homeSchedule.city??'',
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        )
                    ],
                  ),
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
          color: _homeSchedule.city != null && _homeSchedule.city != '' ? Colors.green : Colors.grey,
        ),
      ],
    );
  }
}
