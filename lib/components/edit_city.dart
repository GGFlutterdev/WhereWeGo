import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:uni_events/components/data_search.dart';
import 'package:uni_events/constants.dart';
import 'package:uni_events/models/city.dart';
import 'package:uni_events/schedule/edit_event_schedule.dart';
import 'package:uni_events/services/demolocalizations.dart';

class EditCity extends StatelessWidget {
  const EditCity({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _editSchedule = Provider.of<EditEventSchedule>(context);

    Future<List<City>> getCities() async{
      final List<dynamic> data = jsonDecode(
        await rootBundle.loadString('assets/cities.json'),
      ) as List<dynamic>;
      final List<City> citiesRes = data.map(
        (data) => City.fromJson(data as Map<String, dynamic>),
      ).toList();
      return citiesRes;
    }

    return FutureBuilder<List<City>>(
      future: getCities(),
      builder: (context, snapshot){
        if(snapshot.hasData){
          return Row(
            children: <Widget>[
              Expanded(
                child: InkResponse(
                  onTap: () async {
                    final String? res= await showSearch(
                      context: context,
                      delegate: DataSearch(
                        cities: snapshot.data!,
                      ),
                      useRootNavigator: true,
                    );
                    if(res != null && res != '') _editSchedule.city = res;
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    height: 65,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: kPrimaryColor,
                      ),
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
                            Expanded(
                              child: Text(
                                _editSchedule.city,
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
                color: _editSchedule.city != '' ? Colors.green : Colors.grey,
              ),
            ],
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
