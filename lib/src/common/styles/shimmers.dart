import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../utils/constants/Colors.dart';
import '../../utils/helpers/helper_functions.dart';

class BShimmerEffect extends StatelessWidget {
  const BShimmerEffect({
    Key? key,
    required this.width, required this.height, this.radius = 15, this.color,})
      : super(key: key);
  final double width, height, radius;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final dark = BHelperFunctions.isDarkMode(context);
    return Shimmer.fromColors(
      baseColor: dark ? Colors.grey [850]! : Colors.grey [300]!,
      highlightColor: dark ? Colors.grey [700]! : Colors.grey [100]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color ?? (dark ? BColors.darkgrey : BColors.white),
          borderRadius: BorderRadius.circular(radius),
        ), // BoxDecoration
      ), // Container
    );
  }
}// Shimmer.fromColors