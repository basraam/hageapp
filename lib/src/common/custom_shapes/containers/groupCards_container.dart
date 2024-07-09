import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../data/models/groups_model.dart';
import '../../../features/Taps/screens/Groups/kooxoGuud/widgets/groupCards.dart';

class GroupCards extends StatelessWidget {
  final String userId;

  const GroupCards({super.key, required this.userId});

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
          return const Center(child: CircularProgressIndicator());
        }
        var groups = snapshot.data!;
        return SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: groups.length,
            itemBuilder: (context, index) {
              final group = groups[index];
              return GroupCard(group: group, userId: userId);
            },
          ),
        );
      },
    );
  }
}
