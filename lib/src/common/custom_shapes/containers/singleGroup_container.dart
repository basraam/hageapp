import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/groups_model.dart';
import '../../../features/Taps/screens/Groups/groupChats/groupChat_page.dart';
import '../../../utils/constants/Colors.dart';
import '../../../utils/constants/images.dart';
import '../../../utils/helpers/helper_functions.dart';

class SingleGroupContainer extends StatelessWidget {
  const SingleGroupContainer({
    super.key, required this.group,
  });

  final Group group;

  @override
  Widget build(BuildContext context) {
    final dark = BHelperFunctions.isDarkMode(context);
    return Column(
      children: [
        GestureDetector(
          onTap: () => Get.to(() => GroupChatPage(group: group)),

          child: Row(
            children: [
              Stack(children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(group.groupCoverImage.isEmpty ? BImages.groupProfile : group.groupCoverImage),
                  radius: 35,
                ),
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.green.shade400,
                      width: 4,
                    ),
                  ),
                ),
              ]),

              const SizedBox(width: 5),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      group.groupName,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          fontFamily: 'Tw Cen MT'),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.people,
                          color: BColors.primaryColor,
                          size: 20,
                        ),
                        Text('${group.membersCount}',
                          style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: BColors.primaryColor,
                              fontFamily: 'Tw Cen MT'),
                        ),
                      ],
                    ),
                    Text(
                      group.groupTag,
                      style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                          fontFamily: 'Tw Cen MT'),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Divider(color: dark ? Colors.grey[200] : Colors.grey[400], thickness: 0.5, indent: 10, endIndent: 20),
      ],
    );
  }
}
