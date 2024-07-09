import 'package:flutter/material.dart';
import 'package:hage_mobile_app/src/features/Taps/screens/Groups/kooxahaaga/widgets/GlobalGroupCards.dart';
import 'package:hage_mobile_app/src/features/Taps/screens/Groups/kooxahaaga/widgets/privateGroupCards.dart';
import 'package:hage_mobile_app/src/features/Taps/screens/Groups/kooxahaaga/widgets/sectionTitle.dart';
import 'package:hage_mobile_app/src/utils/constants/Strings.dart';
import 'package:hage_mobile_app/src/utils/constants/images.dart';

class Kooxahaaga extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [

            SectionTitle(title: BString.globalGroups),


            GlobalGroupCard(
              groupName: 'Computer Science',
              members: 56,
              tags: '#CS #Computing #Programming',
              imagePath: BImages.cover3,
            ),
            GlobalGroupCard(
              groupName: 'Software Engineering',
              members: 18,
              tags: '#Programming #Computing',
              imagePath:  BImages.cover4,
            ),


            SizedBox(height: 20),

            SectionTitle(title: BString.privateGroups),


            PrivateGroupCard(
              groupName: 'BCS6 Discussion Group',
              memberName: 'Ayan: Asc Asxaabta',
              imagePath: BImages.newMessage,
            ),
            PrivateGroupCard(
              groupName: 'F4 Team Group',
              memberName: 'Mohamed: Seelayoahay Team',
              imagePath: BImages.cover1,
            ),
            PrivateGroupCard(
              groupName: 'Siblings❤️',
              memberName: 'Abowe: Haye Abyo',
              imagePath: BImages.succsess,
            ),
            PrivateGroupCard(
              groupName: 'Bcs6 Girls',
              memberName: 'Najma: Asc Asxaabta',
              imagePath: BImages.comebackLater,
            ),
            PrivateGroupCard(
              groupName: 'HU CS & IT',
              memberName: 'Nur: Asc Asxaabta',
              imagePath: BImages.cover3,
            ),
          ],
        ),
      ),
    );
  }
}


