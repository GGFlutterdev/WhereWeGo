import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_events/components/sample_propic.dart';
import 'package:uni_events/components/show_loading.dart';
import 'package:uni_events/models/my_user.dart';
import 'package:uni_events/services/database.dart';
import 'package:uni_events/services/demolocalizations.dart';

class HiUser extends StatelessWidget {
  const HiUser({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<String?>(context);
    return _user==null? const ShowLoading() : StreamBuilder<MyUser>(
      stream: Database(uid:_user).userData,
        builder: (context, snapshot){
          if(snapshot.hasData && snapshot.connectionState == ConnectionState.active){
            return Container(
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 8,
              ),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 0.5,
                    color: Theme.of(context).appBarTheme.backgroundColor!,
                  ),
                ),
              ),
              child: Row(
                children: <Widget>[
                  const SamplePropic(),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '${DemoLocalizations.of(context)!.trans("Bentornato")!},',
                        style: Theme.of(context).textTheme.caption,
                      ),
                      Text(
                        snapshot.data!.username!,
                        style: Theme.of(context).textTheme.bodyText1,
                      )
                    ],
                  ),
                ],
              ),
            );
          }else if(snapshot.connectionState == ConnectionState.waiting){
            return Container(
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 8,
              ),
              margin: const EdgeInsets.only(
                bottom: 16,
              ),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 0.5,
                    color: Theme.of(context).appBarTheme.backgroundColor!,
                  ),
                  top: BorderSide(
                    width: 0.5,
                    color: Theme.of(context).appBarTheme.backgroundColor!,
                  ),
                ),
              ),
              child: Row(
                children: const <Widget>[
                  SamplePropic(),
                  SizedBox(
                    width: 15,
                  ),
                  Center(
                    child: ShowLoading(),
                  )
                ],
              ),
            );
          }else{
            return const SizedBox();
          }
        },
    );
  }
}
