import 'package:flutter/material.dart';
import 'package:uni_events/components/my_app_bar.dart';
import 'package:uni_events/components/show_loading.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyAppBar(
        title: 'Loading..',
        home: false,
        showInfo: false,
      ),
      body: SafeArea(
        child: ShowLoading(),
      ),
    );
  }
}
