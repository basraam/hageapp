import 'package:flutter/material.dart';

class PrivateGroupCard extends StatelessWidget {
  final String groupName;
  final String memberName;
  final String imagePath;

  const PrivateGroupCard({
    required this.groupName,
    required this.memberName,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        leading: Stack(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(imagePath),
              radius: 25,
            ),
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.green.shade400,
                  width: 3,
                ),
              ),
            ),
          ],
        ),
        title: Text(
          groupName,
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
        ),
        subtitle: Text(memberName),
      ),
    );
  }
}
