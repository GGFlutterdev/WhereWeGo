import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:uni_events/constants.dart';
import 'package:uni_events/screens/home.dart';
import 'package:uni_events/screens/hot_events.dart';
import 'package:uni_events/screens/personal_area.dart';
import 'package:uni_events/screens/random_event.dart';

class MyBottomNavBar extends StatefulWidget {
  const MyBottomNavBar({ Key? key }) : super(key: key);

  @override
  State<MyBottomNavBar> createState() => _MyBottomNavBarState();
}

class _MyBottomNavBarState extends State<MyBottomNavBar> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final PersistentTabController _controller= PersistentTabController();
    const List<Widget> screens = [
      Home(),
      HotEvents(),
      RandomEvent(),
      PersonalArea(),
    ];

    final List<PersistentBottomNavBarItem> items = [
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.home),
        activeColorPrimary: kPrimaryColor,
        inactiveColorPrimary: Colors.white,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.star),
        activeColorPrimary: kPrimaryColor,
        inactiveColorPrimary: Colors.white,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.question),
        activeColorPrimary: kPrimaryColor,
        inactiveColorPrimary: Colors.white,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.person),
        activeColorPrimary: kPrimaryColor,
        inactiveColorPrimary: Colors.white,
      ),
    ];

    return PersistentTabView(
      context,
      controller: _controller,
      screens: screens,
      items: items,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      resizeToAvoidBottomInset: true,
      navBarStyle: NavBarStyle.style12,
    );
  }
}
