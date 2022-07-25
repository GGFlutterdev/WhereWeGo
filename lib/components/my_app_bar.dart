import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_events/schedule/home_schedule.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget{
  const MyAppBar({
    Key? key,
    required this.title,
    required this.home,
    required this.showInfo,
  }) : super(key: key);

  final String title;
  final bool home;
  final bool showInfo;

  @override
  Widget build(BuildContext context) {
    HomeSchedule? _homeSchedule;
    if(home){
      _homeSchedule = Provider.of<HomeSchedule>(context);
    }
    return AppBar(
      centerTitle: true,
      iconTheme: IconThemeData(
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline1!.copyWith(
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
      ),
      actions: <Widget>[
        if(showInfo) Container(
          margin: const EdgeInsets.only( right: 16),
          child: Icon(
            Icons.info,
            size: 25,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
        ) else if (home) Container(
          margin: const EdgeInsets.only( right: 16),
          child: IconButton(
            onPressed: (){
              if(home) {
                _homeSchedule!.scaffoldState.currentState!.openEndDrawer();
              }
            },
            icon: Icon(
              Icons.filter_list,
              size: 25,
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
          ),
        ) else const SizedBox(),
      ],
      leading: home? IconButton(
        onPressed: () => Navigator.pushNamed(context, '/settings'),
        icon: Icon(
          Icons.person,
          size: 28,
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
      ) : null,
    );
  }

  @override
  Size get preferredSize => const Size(50,50);
}
