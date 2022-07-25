import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_events/components/preview_poster_loading.dart';
import 'package:uni_events/models/event.dart';

class PreviewPoster extends StatelessWidget {
  const PreviewPoster({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final event = Provider.of<Event?>(context);
    return event == null ? const ImageLoading(
      w: 82,
      h: 108,
    ) : CachedNetworkImage(
      imageUrl: event.posterUrl,
      placeholder: (context, url) => const ImageLoading(
        w: 82,
        h: 108,
      ),
      imageBuilder: (context, imageProvider) => ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(
            23,
          ),
          topRight: Radius.circular(
            23,
          ),
        ),
        child:SizedBox(
          width: 82,
          child: FittedBox(
            child: Image(
              image: imageProvider,
            ),
          ),
        ),
      ),
    );
  }
}
