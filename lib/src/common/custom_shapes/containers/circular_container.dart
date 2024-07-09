import 'package:flutter/material.dart';

import '../../../utils/constants/Colors.dart';

class BCircularContainer extends StatelessWidget {
  const BCircularContainer({
    super.key,
    this.child,
    this.height = 300,
    this.width = 300,
    this.radius = 300,
    this.padding = 0,
    this.backgroundColor = BColors.white,
  });

  final double? height;
  final double? width;
  final double radius;
  final double padding;
  final Widget? child;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(400),
        color: backgroundColor,
      ),
      child: child,
    );
  }
}
