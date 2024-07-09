import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BProfilemenu extends StatelessWidget {
  const BProfilemenu(
      {super.key,
      required this.title,
      required this.value,
      required this.onTap});

  final String title;
  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          GestureDetector(
              onTap: onTap,
              child: Icon(Icons.arrow_forward_ios,
                  color: Colors.grey, size: 16.0)),
        ],
      ),
    );
  }
}
