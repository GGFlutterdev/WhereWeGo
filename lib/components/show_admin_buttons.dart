import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_events/components/add_event_button.dart';
import 'package:uni_events/components/show_loading.dart';
import 'package:uni_events/components/your_events_button.dart';
import 'package:uni_events/constants.dart';
import 'package:uni_events/models/my_user.dart';
import 'package:uni_events/services/database.dart';

class ShowAdminButtons extends StatelessWidget {
  const ShowAdminButtons({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<String?>(context);
    return _user == null ? const SizedBox() : 
      StreamBuilder<MyUser>(
        stream: Database(uid:_user).userData,
        builder: (context, snapshot){
          if(snapshot.hasData && snapshot.connectionState == ConnectionState.active){
            final MyUser user = snapshot.data!;
            if(user.isAdmin! && user.isSubscribed!){
              return SizedBox(
                height: buttonHeight*2 + 48,
                child: Column(
                  children: const <Widget>[
                    SizedBox(
                      height: 16,
                    ),
                    AddEventButton(),
                    SizedBox(
                      height: 16,
                    ),
                    YourEventsButton(),
                    SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              );
            } else {
              return const SizedBox(
                height: buttonHeight*2 +16+8,
              );
            }
          }else if(snapshot.connectionState == ConnectionState.waiting){
            return const SizedBox(
              height: buttonHeight*2 +16+8,
              child: Center(
                child: ShowLoading(),
              ),
            );
          }else{
            return const SizedBox();
          }
        },
      );
  }
}
