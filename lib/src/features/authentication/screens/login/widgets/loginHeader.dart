import 'package:flutter/material.dart';

import '../../../../../utils/constants/BSizes.dart';
import '../../../../../utils/constants/Strings.dart';

class loginHeader extends StatelessWidget {
  const loginHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(BString.loginTitle,
            style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: BSizes.sm),
        Text(
          BString.loginSubtitle,
          style: Theme.of(context).textTheme.bodyMedium,
        )
      ],
    );
  }
}
