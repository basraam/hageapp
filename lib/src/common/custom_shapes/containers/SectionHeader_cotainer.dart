import 'package:flutter/material.dart';
class BSectionHeader extends StatelessWidget {
  const BSectionHeader({super.key, required this.title});

  final String title;
  @override
  Widget build(BuildContext context) {

    return  Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding:  const EdgeInsets.only(left: 8.0),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey[900],
          ),
        ),
      ),
    );
  }
}
