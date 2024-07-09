//page 4 - horizantal cards being scrolled horizantally:

import 'package:flutter/material.dart';
class slidingGroup extends StatelessWidget {
  const slidingGroup({super.key, required this.color});
final Color color;
  @override
  Widget build(BuildContext context) {
    return   Padding(
      padding: const EdgeInsets.all(28.0),
      child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                color: color,
              ),
            ),
    );
  }
}

