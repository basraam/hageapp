import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../../../data/models/groups_model.dart';
import '../../../../../../utils/constants/Colors.dart';

class GroupDetailsPage extends StatelessWidget {
  final String groupId;

  GroupDetailsPage({required this.groupId});

  Stream<Group> _getGroupDetails() {
    return FirebaseFirestore.instance.collection('Groups').doc(groupId).snapshots().map(
          (doc) => Group.fromFirestore(doc),
    );
  }

  Stream<List<GroupMember>> _getGroupMembers() {
    return FirebaseFirestore.instance
        .collection('Groups')
        .doc(groupId)
        .collection('groupMembers')
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map((doc) => GroupMember.fromFirestore(doc)).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.green),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: StreamBuilder<Group>(
          stream: _getGroupDetails(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }
            var group = snapshot.data!;
            return Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(group.groupCoverImage),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      group.groupName,
                      style: TextStyle(color: Colors.black),
                    ),
                    Text(
                      'Group · ${group.membersCount} members',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.grey[200],
              child: ListTile(
                leading: Icon(Icons.photo, color: Colors.black),
                title: Text('Media, Links'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: StreamBuilder<Group>(
                stream: _getGroupDetails(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Text(
                      'Loading...',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    );
                  }
                  var group = snapshot.data!;
                  return Text(
                    '${group.membersCount} members',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<List<GroupMember>>(
              stream: _getGroupMembers(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                var members = snapshot.data!;
                return ListView.builder(
                  itemCount: members.length,
                  itemBuilder: (context, index) {
                    final member = members[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(member.profilePicture),
                      ),
                      title: Text(member.name),
                      subtitle: Text(member.id), // Adjust as per your data structure
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    // Add leave group functionality
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: BColors.errorColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const SizedBox(
                    child: Row(
                      children: [
                        Icon(
                          Icons.exit_to_app,
                          color: BColors.white,
                        ),
                        SizedBox(width: 3),
                        Text('Ka bax kooxda',
                            style: TextStyle(
                                color: BColors.white,
                                fontWeight: FontWeight.w900,
                                fontFamily: 'Tw Cen MT',
                                fontSize: 14)),
                      ],
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Add report issue functionality
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: BColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const SizedBox(
                    child: Row(
                      children: [
                        Icon(
                          Icons.report_problem,
                          color: BColors.white,
                        ),
                        SizedBox(width: 3),
                        Text('Ka warbixi dhibaato',
                            style: TextStyle(
                                color: BColors.white,
                                fontWeight: FontWeight.w900,
                                fontFamily: 'Tw Cen MT',
                                fontSize: 14)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
