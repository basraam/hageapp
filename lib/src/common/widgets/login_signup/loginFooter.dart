import 'package:flutter/material.dart';

import '../../../utils/constants/BSizes.dart';
import '../../../utils/constants/images.dart';


class loginFooter extends StatelessWidget {
  const loginFooter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade400), borderRadius: BorderRadius.circular(12)),
      child: SizedBox(
        width: double.infinity,
        child: TextButton.icon(
          onPressed: () {},
          icon: Image.asset(
            BImages.google,
            width: BSizes.iconLg,
            height: BSizes.iconLg,
          ),
          label: Text(
            "ku soo gal Google",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ),
    );
  }
}
