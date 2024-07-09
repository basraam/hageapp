import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hage_mobile_app/src/features/personalization/controllers/user_controller.dart';
import '../../../../../common/custom_shapes/containers/ProfileImage_container.dart';
import '../../../../../common/styles/shimmers.dart';
import '../../../../../utils/constants/BSizes.dart';
import '../../../../../utils/constants/Colors.dart';
import '../../../../../utils/constants/images.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../Posts/widgets/AddNewPost.dart';

class AddPostContainer extends StatelessWidget {

  const AddPostContainer({super.key});

  void _navigateToAddPostPage(BuildContext context) {
    // Implement navigation to AddPostPage
    Get.to(() =>  AddNewPostPage());
  }

  @override
  Widget build(BuildContext context) {
    final dark = BHelperFunctions.isDarkMode(context);
    final controller = Get.put(UserController());
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: BSizes.spaceBtwItems),
      child: Container(
        padding: const EdgeInsets.all(BSizes.md),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(BSizes.cardRadiusLg),
          border: Border.all(color: Colors.grey[300]!),
          color: dark? BColors.dark: BColors.backgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child:  Row(
            children: [
              Obx(() {
                final networkImage = controller.user.value.profilePic;
                final image = networkImage.isNotEmpty
                    ? networkImage
                    : BImages.greenBackground;
                return controller.imageUploading.value
                    ? const BShimmerEffect(
                    width: 20, height: 20, radius: 20)
                    : BProfileImage(
                    image: image,
                    height: 20,
                    width: 20,
                    isNetworkImage: networkImage.isNotEmpty);
              }),
              const SizedBox(width: 16.0),
              Expanded(
                child: GestureDetector(
                  onTap: () => _navigateToAddPostPage(context),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.edit, color: Colors.grey[500]),
                        const SizedBox(width: 8.0),
                        Text(
                          "Halkaan ku qor fikirkaada...",
                          style: TextStyle(color: Colors.grey[500]),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }
}
