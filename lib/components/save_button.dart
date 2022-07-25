import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_events/components/show_loading.dart';
import 'package:uni_events/models/event.dart';
import 'package:uni_events/services/database.dart';

class SaveButton extends StatefulWidget {
  const SaveButton({ Key? key }) : super(key: key);

  @override
  State<SaveButton> createState() => _SaveButtonState();
}

class _SaveButtonState extends State<SaveButton> {
  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    final _event = Provider.of<Event?>(context);
    final _user = Provider.of<String?>(context);
    return _event == null || _user ==null ? const SizedBox() : FutureBuilder<bool>(
      future: Database(uid: _user).isSaved(_event.uid),
      builder: (context, snap) => snap.hasData ? InkResponse(
        onTap: () async{
          setState(() {
            _loading = true;
          });
          snap.data! ? await Database(uid: _user).removeSaved(_event.uid) : await Database(uid: _user).addSaved(_event.uid);
          setState(() {
            _loading = false;
          });
        } ,
        child: !_loading ? Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(100),
            ),
            color: Theme.of(context).cardColor,
            border: Border.all(
              color: Theme.of(context).appBarTheme.backgroundColor!,
            ),
          ),
          width: 60,
          height: 60,
          child: Icon(
            snap.data! ? Icons.star : Icons.star_border,
            size: 40,
            color: Theme.of(context).appBarTheme.backgroundColor,
          ),
        ) : Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(100),
            ),
            color: Theme.of(context).cardColor,
            border: Border.all(
              color: Theme.of(context).appBarTheme.backgroundColor!,
            ),
          ),
          width: 60,
          height: 60,
          child: const ShowLoading(),
        ),
      ) : const SizedBox(),
    );
  }
}
