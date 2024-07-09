import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hage_mobile_app/src/features/Taps/screens/Groups/kooxoGuud/widgets/groupCards.dart';
import 'package:hage_mobile_app/src/features/Taps/screens/Groups/kooxoGuud/widgets/othergroupsList.dart';
import 'package:hage_mobile_app/src/utils/constants/BSizes.dart';
import 'package:hage_mobile_app/src/utils/constants/Colors.dart';
import 'package:hage_mobile_app/src/utils/constants/Strings.dart';

import '../../../../../common/custom_shapes/containers/groupCards_container.dart';
import 'CreateNewGroup.dart';

class kooxoGuud extends StatelessWidget {
  final String userId;
  kooxoGuud({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: BSizes.spaceBtwSections),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        BString.groups,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          BString.more,
                          style: TextStyle(
                              fontSize: 20,
                              color: BColors.primaryColor,
                              fontWeight: FontWeight.w700),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: BSizes.spaceBtwItems),

                  // Add the group cards here

                   GroupCards(userId: userId),

                  const SizedBox(height: BSizes.spaceBtwItems),
                  const KooxoKaleList()
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 20,
            child: FloatingActionButton(
              onPressed: () {
                Get.to(() => CreateNewGroupPage());
                // Add your action here
              },
              backgroundColor: BColors.primaryColor,
              shape: const CircleBorder(), // Green background color
              child: const Icon(
                Icons.add,
                color: Colors.white, // White icon color
              ), // Circular shape with 100% radius
            ),
          ),
        ],
      ),
    );
  }
}
