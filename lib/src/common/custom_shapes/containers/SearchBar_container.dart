import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hage_mobile_app/src/utils/constants/Colors.dart';
import '../../../features/personalization/controllers/user_controller.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../SearchPage.dart';
class BSearchBar extends StatelessWidget {
  final String userId;
  const BSearchBar({
    super.key, required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    final dark = BHelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: () => Get.to(() =>  SearchPage(userId: userId,)),

      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: TextField(
            enabled: false,
          decoration: InputDecoration(
          prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(60.0),
        ),
    enabledBorder: OutlineInputBorder(
    borderSide: const BorderSide(
    color: Color.fromARGB(255, 0, 149, 57),
    width: 2.0,
    ),
    borderRadius: BorderRadius.circular(60.0),
    ),
    focusedBorder: OutlineInputBorder(
    borderSide: const BorderSide(
    color: Color(0xFF8DC26F),
    width: 2.0,
    ),
    borderRadius: BorderRadius.circular(60.0),
    ),
    fillColor: dark?BColors.darkgrey: const Color.fromARGB(245, 243, 245, 244),
    filled: true,
    hintText: "Raadi..",
    hintStyle: TextStyle(color: Colors.grey[500]),
    contentPadding: const EdgeInsets.symmetric(vertical: 10.0), // Adjust this value to make the height smaller
    ),
    style: const TextStyle(fontSize: 16), // Adjust the font size if necessary
    )
),
    );
  }
}

