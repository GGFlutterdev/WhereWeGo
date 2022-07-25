import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_events/components/edit_city.dart';
import 'package:uni_events/components/edit_when.dart';
import 'package:uni_events/components/my_form_field_with_validator.dart';
import 'package:uni_events/constants.dart';
import 'package:uni_events/schedule/edit_event_schedule.dart';
import 'package:uni_events/services/database.dart';
import 'package:uni_events/services/demolocalizations.dart';

class EditEventFields extends StatelessWidget {
  const EditEventFields({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _editSchedule = Provider.of<EditEventSchedule>(context);
    final _user = Provider.of<String?>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 16,
      ),
      child: Column(
        children: <Widget>[
          MyFormFieldWithValidator(
            inputAction: TextInputAction.done,
            inputType: TextInputType.text,
            labelText: DemoLocalizations.of(context)!.trans('Nome')!,
            obscured: false,
            isValidValue: _editSchedule.name.isNotEmpty,
            onChanged: (val) => _editSchedule.name = val.toString(),
            initialValue: _editSchedule.name,
          ),
          const SizedBox(
            height: 16,
          ),
          MyFormFieldWithValidator(
            inputAction: TextInputAction.done,
            inputType: TextInputType.multiline,
            numberOfLines: 5,
            labelText: DemoLocalizations.of(context)!.trans('Descrizione')!,
            obscured: false,
            isValidValue: _editSchedule.description.isNotEmpty,
            onChanged: (val) => _editSchedule.description = val.toString(),
            initialValue: _editSchedule.description,
          ),
          const SizedBox(
            height: 16,
          ),
          MyFormFieldWithValidator(
            inputAction: TextInputAction.done,
            inputType: TextInputType.text,
            labelText: DemoLocalizations.of(context)!.trans('Indirizzo')!,
            obscured: false,
            isValidValue: _editSchedule.location.isNotEmpty,
            onChanged: (val) => _editSchedule.location = val.toString(),
            initialValue: _editSchedule.location,
          ),
          const SizedBox(
            height: 16,
          ),
          const EditCity(),
          const SizedBox(
            height: 16,
          ),
          const EditWhen(),
          const SizedBox(
            height: 16,
          ),
          if (_user == null) const SizedBox() else ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: kPrimaryColor,
            ),
            onPressed: () async{
              if(_editSchedule.poster != null){
                final String posterUrl = await Database().changePosterAndGetUrl(_editSchedule.posterUrl, _editSchedule.poster!);
                Database(uid: _editSchedule.uid).updateEvent(_user, _editSchedule.name, _editSchedule.description, _editSchedule.city, _editSchedule.location, _editSchedule.when!, posterUrl);
              } else {
                Database(uid: _editSchedule.uid).updateEvent(_user, _editSchedule.name, _editSchedule.description, _editSchedule.city, _editSchedule.location, _editSchedule.when!, _editSchedule.posterUrl);
              }
              Future.delayed(
                Duration.zero,
                () => Navigator.pop(context),
              );
            },
            child: SizedBox(
              height: 60,
              child: Center(
                child: Text(
                  DemoLocalizations.of(context)!.trans('Modifica evento')!,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
