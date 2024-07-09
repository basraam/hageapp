import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/constants/Strings.dart';
import '../../../utils/helpers/helper_functions.dart';
class loginFormDevider extends StatelessWidget {
  const loginFormDevider({super.key,  required this.deviderText});

  final String? deviderText;

  @override
  Widget build(BuildContext context) {
    final dark = BHelperFunctions.isDarkMode(context);
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(child: Divider(color: dark ? Colors.grey[200] : Colors.grey[500], thickness: 0.5, indent: 50, endIndent: 2)),

          Text(deviderText!, style: Theme.of(context).textTheme.labelLarge),

          Flexible(child: Divider(color: dark ? Colors.grey[200] : Colors.grey[500], thickness: 0.5, indent: 2, endIndent: 50)),
    ]);
  }
}
