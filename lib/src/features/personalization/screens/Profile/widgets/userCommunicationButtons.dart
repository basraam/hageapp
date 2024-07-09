import 'package:flutter/material.dart';
import 'package:hage_mobile_app/src/utils/constants/BSizes.dart';
import '../../../../../utils/constants/Colors.dart';

class communicButtons extends StatelessWidget {
  const communicButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: double.infinity,
      child: Container(
        color: const Color(0XffE0E9DC),
        padding: const EdgeInsets.symmetric(horizontal: BSizes.defaultSpace),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                backgroundColor: BColors.backgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const SizedBox(
                child: Row(
                  children: [
                    Icon(
                      Icons.add_circle,
                      color: BColors.primaryColor,
                    ),
                    SizedBox(width: 3),
                    Text('Ku Darso',
                        style: TextStyle(
                            color: BColors.primaryTextColor,
                            fontWeight: FontWeight.w900,
                            fontFamily: 'Tw Cen MT',
                            fontSize: 14)),
                  ],
                ),
              ),
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                backgroundColor: BColors.backgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const SizedBox(
                child: Row(
                  children: [
                    Icon(
                      Icons.message,
                      color: BColors.primaryColor,
                    ),
                    SizedBox(width: 3),
                    Text('La Hadal',
                        style: TextStyle(
                            color: BColors.primaryTextColor,
                            fontWeight: FontWeight.w900,
                            fontFamily: 'Tw Cen MT',
                            fontSize: 14)),
                  ],
                ),
              ),
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                backgroundColor: BColors.backgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const SizedBox(
                child: Row(
                  children: [
                    Icon(
                      Icons.info,
                      color: BColors.primaryColor,
                    ),
                    SizedBox(width: 3),
                    Text('Ka warbixi',
                        style: TextStyle(
                            color: BColors.primaryTextColor,
                            fontWeight: FontWeight.w900,
                            fontFamily: 'Tw Cen MT',
                            fontSize: 14)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
