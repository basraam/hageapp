import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hage_mobile_app/src/features/Taps/screens/Groups/kooxoGuud/widgets/groupDescriptionPage.dart';
import 'package:hage_mobile_app/src/utils/constants/images.dart';
import '../../../../../../data/models/groups_model.dart';
import '../../../../../../utils/constants/Colors.dart';

class GroupCard extends StatelessWidget {
  final Group group;
  final String userId;

  const GroupCard({super.key, required this.group, required this.userId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Get.to(() => GroupDescriptionPage(group: group, userId: userId)),
      child: Container(
        width: 150,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            ClipRRect(
              child: Image.network(
                BImages.cover1,
                fit: BoxFit.cover,
                width: 50,
                height: 150,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.6),
                    Colors.black.withOpacity(0.3),
                    Colors.transparent
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 10,
              right: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    group.groupName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.people,
                          size: 16, color: BColors.primaryColor),
                      const SizedBox(width: 4),
                      Text(
                        '${group.membersCount} members'.toString(),
                        style: const TextStyle(
                            color: BColors.primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
