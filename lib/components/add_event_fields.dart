import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_events/components/my_back_button.dart';
import 'package:uni_events/components/my_form_field_with_validator.dart';
import 'package:uni_events/components/pick_image_from_gallery_create.dart';
import 'package:uni_events/components/select_city.dart';
import 'package:uni_events/components/select_when.dart';
import 'package:uni_events/constants.dart';
import 'package:uni_events/schedule/add_event_schedule.dart';
import 'package:uni_events/services/database.dart';
import 'package:uni_events/services/demolocalizations.dart';

class AddEventFields extends StatelessWidget {
  const AddEventFields({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _addSchedule = Provider.of<AddEventSchedule>(context);
    final _user = Provider.of<String?>(context);
    return ListView(
      children: <Widget>[
        const MyBackButton(),
        const SizedBox(
          height: 20,
        ),
        const PickImageFromGalleryCreate(),
        Padding(
          padding: const EdgeInsets.all(
            16,
          ),
          child: Column(
            children: <Widget>[
              MyFormFieldWithValidator(
                inputAction: TextInputAction.done,
                inputType: TextInputType.text,
                labelText: DemoLocalizations.of(context)!.trans('Nome')!,
                obscured: false,
                isValidValue: _addSchedule.name.isNotEmpty,
                onChanged: (val) => _addSchedule.name = val.toString(),
                initialValue: _addSchedule.name,
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
                isValidValue: _addSchedule.description.isNotEmpty,
                onChanged: (val) => _addSchedule.description = val.toString(),
                initialValue: _addSchedule.description,
              ),
              const SizedBox(
                height: 16,
              ),
              MyFormFieldWithValidator(
                inputAction: TextInputAction.done,
                inputType: TextInputType.text,
                labelText: DemoLocalizations.of(context)!.trans('Indirizzo')!,
                obscured: false,
                isValidValue: _addSchedule.location.isNotEmpty,
                onChanged: (val) => _addSchedule.location = val.toString(),
                initialValue: _addSchedule.location,
              ),
              const SizedBox(
                height: 16,
              ),
              const SelectCity(),
              const SizedBox(
                height: 16,
              ),
              const SelectWhen(),
              const SizedBox(
                height: 32,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(kPrimaryColor),
                ),
                onPressed: _addSchedule.validateFields() ? (){
                  Database(uid: _user).createEvent(_addSchedule.name, _addSchedule.description, _addSchedule.city, _addSchedule.location, _addSchedule.when!, Timestamp.now(), _addSchedule.poster!);
                  Navigator.pop(context);
                } : null,
                child: SizedBox(
                  height: 60,
                  child: Center(
                    child: Text(
                      DemoLocalizations.of(context)!.trans('Aggiungi evento')!,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
