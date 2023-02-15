import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImage extends StatelessWidget {
  final String imageUrl;

  CachedImage({
    @required this.imageUrl,
  });
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      repeat: ImageRepeat.repeat,
      useOldImageOnUrlChange: true,
      placeholder: (context, url) => Center(
        child: CircularProgressIndicator(
          color: Color(0xFF0D67B5),
        ),
      ),
      errorWidget: (context, url, error) => Center(
        child: CircleAvatar(
            radius: 20,
            child: Icon(
              Icons.error,
              size: 20,
            )),
      ),
      imageUrl: "$imageUrl",
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(11),
            image: DecorationImage(image: imageProvider, fit: BoxFit.fill)),
      ),
    );
  }
}
