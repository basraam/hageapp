import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/BSizes.dart';
import '../../../utils/constants/Colors.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../styles/shimmers.dart';

class BProfileImage extends StatelessWidget {
  const BProfileImage({
    super.key,
    this.width = 60,
    this.height = 60,
    this.overlayColor,
    this.backgroundColor,
    required this.image,
    this.fit = BoxFit.cover,
    this.padding = BSizes.sm,
    this.isNetworkImage = false,
  });

  final BoxFit? fit;
  final String image;
  final bool isNetworkImage;
  final Color? overlayColor;
  final Color? backgroundColor;
  final double width, height, padding;

  @override
  Widget build(BuildContext context) {
    return
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: CircleAvatar(
            radius: width,
            child: isNetworkImage
                ? CachedNetworkImage(
                    fit: fit,
                    color: overlayColor,
                    imageUrl: image,
                    progressIndicatorBuilder: (context, url, downloadProgress) =>
                        const BShimmerEffect(
                      width: 55,
                      height: 55,
                      radius: 55,
                    ),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  )
                : CircleAvatar(
                    radius: width,
                    backgroundColor: backgroundColor ??
                        (BHelperFunctions.isDarkMode(context)
                            ? BColors.dark
                            : BColors.white),
                    backgroundImage: AssetImage(image),
                  ),
          ),
        );
  }
}
