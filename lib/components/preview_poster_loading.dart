import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageLoading extends StatelessWidget {
  final double w;
  final double h;
  const ImageLoading({ Key? key, required this.w, required this.h }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 16,
      ),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            23,
          ),
          topRight: Radius.circular(
            23,
          ),
        ),
      ),
      height: w,
      width: h,
      child: Center(
        child: Platform.isAndroid ? const CircularProgressIndicator() : const CupertinoActivityIndicator(),
      ),
    );
  }
}
