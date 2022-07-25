import 'package:flutter/material.dart';
import 'package:uni_events/components/show_loading.dart';
import 'package:uni_events/constants.dart';

class LoadingPreview extends StatelessWidget {
  const LoadingPreview({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: cardHeight,
      margin: const EdgeInsets.only(
        bottom: 32,
      ),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(23),
        ),
        color: Colors.grey,
      ),
      child: const Center(
        child: ShowLoading(),
      ),
    );
  }
}
