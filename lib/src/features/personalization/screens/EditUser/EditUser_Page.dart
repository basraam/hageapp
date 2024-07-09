import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hage_mobile_app/src/features/personalization/screens/EditUser/widgets/Changing/ChangeGender.dart';
import 'package:hage_mobile_app/src/features/personalization/screens/EditUser/widgets/Changing/changeBio.dart';
import 'package:hage_mobile_app/src/features/personalization/screens/EditUser/widgets/Changing/changePhoneNumber.dart';
import 'package:hage_mobile_app/src/features/personalization/screens/EditUser/widgets/Changing/changeUsername.dart';
import 'package:hage_mobile_app/src/features/personalization/screens/EditUser/widgets/Changing/changefullName.dart';
import 'package:hage_mobile_app/src/features/personalization/screens/EditUser/widgets/ProfileMenu.dart';
import 'package:hage_mobile_app/src/utils/popups/loaders.dart';
import '../../../../common/custom_shapes/containers/ProfileImage_container.dart';
import '../../../../common/custom_shapes/containers/SectionHeader_cotainer.dart';
import '../../../../common/styles/shimmers.dart';
import '../../../../data/reposotories/Authentication/authentication_repository.dart';
import '../../../../utils/constants/BSizes.dart';
import '../../../../utils/constants/images.dart';
import '../../controllers/user_controller.dart';

class EditUserPage extends StatelessWidget {
  const EditUserPage({super.key});

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(UserController());

    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Edit Profile', style: TextStyle(color: Colors.green)),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.green),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Column(
                children: [
                  Obx(() {
                    final networkImage = controller.user.value.profilePic;
                    final image = networkImage.isNotEmpty
                        ? networkImage
                        : BImages.greenBackground;
                    return controller.imageUploading.value
                        ? const BShimmerEffect(
                            width: 80, height: 80, radius: 80)
                        : BProfileImage(
                            image: image,
                            width: 80,
                            height: 80,
                            isNetworkImage: networkImage.isNotEmpty);
                  }),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () => controller.uploadUserProfilePicture(),
                    child: const Text(
                      'Badal sawirka profile-ka',
                      style: TextStyle(color: Colors.green, fontSize: 15),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: BSizes.spaceBtwInputFields / 2),

              const Divider(
                color: Colors.grey,
              ),
              const SizedBox(height: BSizes.spaceBtwItems),

              const BSectionHeader(
                title: 'Macluumaadka profile-ka',
              ),

              const SizedBox(height: BSizes.spaceBtwItems),

              Obx(() {
                if (controller.profileLoading.value) {
                  return const BShimmerEffect(width: 80, height: 15);
                } else {
                  return BProfilemenu(
                      title: "Magaca",
                      value: controller.user.value.fullName,
                      onTap: () => Get.to(() => const ChangeFullname()));
                }
              }),

              Obx(() {
                if (controller.profileLoading.value) {
                  return const BShimmerEffect(width: 80, height: 15);
                } else {
                  return BProfilemenu(
                      title: "Naanays",
                      value: controller.user.value.username,
                      onTap: () => Get.to(() => const ChangeUsername()));
                }
              }),
              Obx(() {
                if (controller.profileLoading.value) {
                  return const BShimmerEffect(width: 80, height: 15);
                } else {
                  return BProfilemenu(
                      title: "Bio",
                      value: controller.user.value.bio,
                      onTap: () => Get.to(() => const ChangeBio()));
                }
              }),
              Obx(() {
                if (controller.profileLoading.value) {
                  return const BShimmerEffect(width: 80, height: 15);
                } else {
                  return BProfilemenu(
                      title: "Heerka",
                      value: controller.user.value.level,
                      onTap: () {});
                }
              }),

              const SizedBox(height: BSizes.spaceBtwItems),

              const Divider(
                color: Colors.grey,
              ),

              const SizedBox(height: BSizes.spaceBtwItems),

              const BSectionHeader(
                title: 'Macluumaadka Shaqsiga',
              ),

              const SizedBox(height: BSizes.spaceBtwItems),

              Obx(() {
                if (controller.profileLoading.value) {
                  return const BShimmerEffect(width: 80, height: 15);
                } else {
                  return BProfilemenu(
                      title: "Jinsiga",
                      value: controller.user.value.sex,
                      onTap: () => Get.to(() => const changeGender()));
                }
              }),
              Obx(() {
                if (controller.profileLoading.value) {
                  return const BShimmerEffect(width: 80, height: 15);
                } else {
                  return BProfilemenu(
                      title: "Email-ka",
                      value: controller.user.value.email,
                      onTap: () {
                        BLoaders.errorSnackBar(
                            title: 'waa ka xunahay!',
                            message: 'Lama badali karo ciwaankaada email-ka');
                      });
                }
              }),
              Obx(() {
                if (controller.profileLoading.value) {
                  return const BShimmerEffect(width: 80, height: 15);
                } else {
                  return BProfilemenu(
                      title: "PhoneNumber",
                      value: controller.user.value.phoneNumber,
                      onTap: () => Get.to(() => const ChangePhoneNumber()));
                }
              }),
              Obx(() {
                if (controller.profileLoading.value) {
                  return const BShimmerEffect(width: 80, height: 15);
                } else {
                  return BProfilemenu(
                      title: "Dhalashada",
                      value: controller.user.value.bod.toString(),
                      onTap: () {});
                }
              }),

              const SizedBox(height: BSizes.spaceBtwItems),
              const Divider(
                color: Colors.grey,
              ),

              const SizedBox(height: BSizes.spaceBtwItems),

              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(height: BSizes.spaceBtwItems),
                    SizedBox(
                        width: 150,
                        child: TextButton(
                            style: ElevatedButton.styleFrom().copyWith(
                              backgroundColor:
                                  const WidgetStatePropertyAll<Color>(
                                      Colors.black12),
                            ),
                            onPressed: () =>
                                AuthenticationRepository.instance.logout(),
                            child: const Text("Ka bax ciwaanka",
                                style: TextStyle(
                                    color: Colors.red, fontSize: 14)))),
                    const SizedBox(height: BSizes.spaceBtwItems),
                    SizedBox(
                      width: 150,
                      child: TextButton(
                        style: ElevatedButton.styleFrom().copyWith(
                          backgroundColor:
                              const WidgetStatePropertyAll<Color>(Colors.red),
                        ),
                        onPressed: () => controller.deleteAccountWarningPopup(),
                        child: const Text("Tirtir ciwaanka",
                            style:
                                TextStyle(color: Colors.white, fontSize: 14)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: BSizes.spaceBtwItems),

              //const EditUserForm(),
            ],
          ),
        ),
      ),
    );
  }
}
