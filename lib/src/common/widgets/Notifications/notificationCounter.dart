import 'package:flutter/material.dart';

import '../../../utils/constants/Colors.dart';

class BNotificationsCounter extends StatelessWidget {
  const BNotificationsCounter({
    super.key, required this.onPressed, this.iconColor,
  });

  final Color? iconColor;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(onPressed: onPressed , icon: Icon(Icons.notifications , color: iconColor)),
        Positioned(
          right: 0,
          child: Container(
            height: 18,
            width: 18,
            decoration: BoxDecoration(
              color: BColors.backgroundColor,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(
              child: Text('3', style: Theme.of(context).textTheme.labelLarge!.apply(color: BColors.primaryColor, fontFamily: 'Tw Cen MT', fontWeightDelta: 3)),
            ),
          ),
        ),
      ],
    );
  }
}
