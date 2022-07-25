import 'package:flutter/material.dart';
import 'package:uni_events/components/filter_button.dart';

class MySliverAppBar extends StatelessWidget {
  const MySliverAppBar({ Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SliverAppBar(
      pinned: true,
      centerTitle: true,
      title: FilterButton(),
      elevation: 0,
      backgroundColor: Colors.transparent,
      actions: <Widget>[
        SizedBox()
      ],
    );
  }
}
