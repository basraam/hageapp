import 'package:flutter/material.dart';
import 'package:hage_mobile_app/src/common/styles/spacing_styles.dart';
import 'package:lottie/lottie.dart';
import '../../../utils/constants/BSizes.dart';
import '../../../utils/constants/Strings.dart';
import '../../../utils/helpers/helper_functions.dart';


class successScreen extends StatelessWidget {
  const successScreen(
      {super.key, required this.image, required this.title, required this.subtitle, required this.onpressed});

  final String image, title, subtitle;
  final VoidCallback onpressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: spacingStyles.paddingWithAppBarHeight * 2,
          child: Column(
            children: [

              ///Image:
              Lottie.asset(image, width: MediaQuery.of(context).size.width * 0.6),

              ///Title & SubTitle:

              const SizedBox(height: BSizes.spaceBtwSections),
              Text(title, style: Theme
                  .of(context)
                  .textTheme
                  .headlineMedium),
              const SizedBox(height: BSizes.spaceBtwItems),
              Text(subtitle, style: Theme
                  .of(context)
                  .textTheme
                  .labelMedium),
              const SizedBox(height: BSizes.spaceBtwSections),

              ///continue button:
              SizedBox(width: double.infinity,
                  child: ElevatedButton(onPressed: onpressed, child: const Text(BString.siiWad))),

            ],
          ),
        ),
      ),
    );
  }
}
