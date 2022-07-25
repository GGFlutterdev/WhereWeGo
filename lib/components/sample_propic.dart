import 'package:flutter/material.dart';
import 'package:uni_events/constants.dart';

class SamplePropic extends StatelessWidget {
  const SamplePropic({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: propicSize,
      width: propicSize,
      decoration: const BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.all(
          Radius.circular(
            100,
          ),
        ),
      ),
      child: const Center(
        child: Icon(
          Icons.person,
          size: 40,
          color: Colors.black,
        ),
      ),
    );
  }
}
