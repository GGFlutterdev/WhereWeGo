import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:uni_events/constants.dart';
import 'package:uni_events/models/event.dart';
import 'package:uni_events/screens/edit_event_page.dart';
import 'package:uni_events/services/database.dart';

class EditPreviewButtons extends StatelessWidget {
  const EditPreviewButtons({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _event = Provider.of<Event?>(context);
    return Row(
      children: <Widget>[
        InkResponse(
          onTap: () => _event == null ? {} : pushNewScreen(context, screen: EditEventPage(
              event: _event,
            ),
          ),
          child: Container(
            decoration: const BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.all(
                Radius.circular(100),
              ),
            ),
            width: 30,
            height: 30,
            child: const Icon(
              Icons.edit,
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        InkResponse(
          onTap: () => showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                elevation: 1,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                title: Text(
                  "Sei sicuro di voler eliminare quest'evento?",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'Annulla',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: kPrimaryColor,
                        ),
                      ),
                    ),
                    InkResponse(
                      onTap: (){
                        if(_event != null){
                          Database().deleteEvent(_event.uid);
                          Navigator.pop(context);
                        }
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: kPrimaryColor,
                        ),
                        width: 100,
                        height: 40,
                        child: Center(
                          child: Text(
                            'Elimina',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
          child: Container(
            decoration: const BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.all(
                Radius.circular(100),
              ),
            ),
            width: 30,
            height: 30,
            child: const Icon(
              Icons.delete,
            ),
          ),
        ),
      ],
    );
  }
}
