import 'package:flutter/material.dart';

import '../../../../../utils/constants/images.dart';

class BAvatarWIthEditButton extends StatelessWidget {
  const BAvatarWIthEditButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 50,
      backgroundImage: const AssetImage(BImages.cover1),
      child: Align(
        alignment: Alignment.bottomRight,
        child: CircleAvatar(
          backgroundColor: Colors.white,
          radius: 16,
          child: IconButton(
            icon:
            const Icon(Icons.edit, color: Colors.green, size: 16),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}

