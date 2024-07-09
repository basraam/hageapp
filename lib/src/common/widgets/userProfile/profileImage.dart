import 'package:flutter/material.dart';

class profileImage extends StatelessWidget {
  const profileImage({super.key, required this.img, required this.radius, required this.width, required this.height});
  final double radius, width, height;
  final String img;

  @override
  Widget build(BuildContext context) {
    return  Stack(children: [
      CircleAvatar(
        backgroundImage: AssetImage(img),
        // Replace with your image
        radius: radius,
      ),
      // circle border that rounds the profile picture
      Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.green.shade400,
            width: 3,
          ),
        ),
      ),
    ]);
  }
}
