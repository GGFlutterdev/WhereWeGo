import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_events/components/preview_poster_loading.dart';
import 'package:uni_events/constants.dart';
import 'package:uni_events/models/my_user.dart';
import 'package:uni_events/services/auth.dart';
import 'package:uni_events/services/database.dart';

class ImageProfileAndName extends StatelessWidget {
  const ImageProfileAndName({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<String?>(context);
    return StreamProvider.value(
      value: Database(uid: _user).userData,
      catchError: (context, event){},
      initialData: null,
      child: Consumer<MyUser?>(
        builder: (context, schedule, _) => schedule != null ? 
          Column(
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              FutureBuilder<String?>(
                future: Database().getLocationName(_user!),
                builder: (context, snap){
                  if(snap.hasData){
                    return Text(
                      snap.data ?? '',
                      style: Theme.of(context).textTheme.headline1,
                      overflow: TextOverflow.ellipsis,
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const SizedBox(
                    width: 50,
                  ),
                  CachedNetworkImage(
                    imageUrl: schedule.propic!,
                    placeholder: (context, url) => const ImageLoading(
                      w: 100,
                      h: 100,
                    ),
                    imageBuilder: (context, imageProvider) => SizedBox(
                      height: 120,
                      width: 120,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(100),
                        ),
                        child: Image(
                          fit: BoxFit.cover,
                          image: imageProvider,
                        ),
                      ),
                    ),
                  ),
                  InkResponse(
                    onTap: () => Auth().googleSignOut(),
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(100),
                        ),
                      ),
                      child: const Icon(
                        Icons.logout,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ) : const SizedBox(),
      ),
    );
  }
}
