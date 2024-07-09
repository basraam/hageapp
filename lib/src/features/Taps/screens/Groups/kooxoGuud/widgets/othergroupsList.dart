import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../../../common/custom_shapes/containers/singleGroup_container.dart';
import '../../../../../../data/models/groups_model.dart';
import '../../../../../../utils/constants/BSizes.dart';
import '../../../../../../utils/constants/Strings.dart';

class KooxoKaleList extends StatelessWidget {
  const KooxoKaleList({super.key});

  Stream<List<Group>> _getGroups() {
    return FirebaseFirestore.instance.collection('Groups').snapshots().map(
          (snapshot) => snapshot.docs.map((doc) => Group.fromFirestore(doc)).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Group>>(
      stream: _getGroups(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        var groups = snapshot.data!;
        return Column(
          children: [
            Row(
              children: [
                Text(
                  BString.otherGroups,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ),
            const SizedBox(height: BSizes.spaceBtwItems),
            ...groups.map((group) => SingleGroupContainer(group: group)).toList(),
          ],
        );
      },
    );
  }
}
