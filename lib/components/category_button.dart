import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:uni_events/constants.dart';
import 'package:uni_events/schedule/category_schedule.dart';
import 'package:uni_events/screens/events_for_category.dart';

class CategoryButton extends StatelessWidget {
  final String category;
  const CategoryButton({ Key? key, required this.category }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      splashFactory: NoSplash.splashFactory,
      onTap: () => pushNewScreen(
        context,
        screen: ChangeNotifierProvider.value(
            value: CategorySchedule.initialize(category),
            child: EventsForCategory(
              category: category,
            ),
          ),
        withNavBar: true, // OPTIONAL VALUE. True by default.
        pageTransitionAnimation: PageTransitionAnimation.cupertino,
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        width: 300,
        height: 80,
        margin: const EdgeInsets.only(
          bottom: 20,
        ),
        child: Center(
          child: Text(
            category == 'fun' ? 'Divertirmi' :
            category == 'relax' ? 'Rilassarmi' :
            category == 'eat' ? 'Mangiare' : '',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      ),
    );
  }
}
