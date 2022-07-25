import 'package:flutter/material.dart';
import 'package:uni_events/components/show_loading.dart';

class LoadingSettingsButton extends StatelessWidget {
  const LoadingSettingsButton({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Theme.of(context).appBarTheme.backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(23.0),
          ),
      ),
      onPressed: null,
      child: SizedBox(
        height: 60,
        width: MediaQuery.of(context).size.width*0.75,
        child: const Center(
          child: ShowLoading(),
        ),
      ),
    );
  }
}
