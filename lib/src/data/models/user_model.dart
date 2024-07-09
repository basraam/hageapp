import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  String fullName;
  String username;
  final String password;
   String bio;
   String level;
   String sex;
  final String email;
  String profilePic;
  String phoneNumber;
  DateTime bod;
  final bool isOnline;
  final DateTime lastSeen;
  final Timestamp signedAt;

  UserModel({
    required this.id,
    required this.fullName,
    required this.username,
    required this.password,
    required this.bio,
    required this.level,
    required this.sex,
    required this.email,
    required this.profilePic,
    required this.phoneNumber,
    required this.bod,
    required this.isOnline,
    required this.lastSeen,
    required this.signedAt,
  });

  factory UserModel.empty() {
    return UserModel(
      id: '',
      fullName: '',
      username: '',
      password: '',
      bio: '',
      level: '',
      sex: '',
      email: '',
      profilePic: '',
      phoneNumber: '',
      bod: DateTime.now(),
      isOnline: false,
      lastSeen: DateTime.now(),
      signedAt: Timestamp.now(),
    );
  }

  factory UserModel.fromSnapshot(DocumentSnapshot doc) {
  return UserModel(
  id: doc.id,
  fullName: doc['fullName'],
  username: doc['username'],
  password: doc['password'],
  profilePic: doc['profilePic'],
  bio: doc['bio'],
  level: doc['level'],
  sex: doc['sex'],
  email: doc['email'],
  phoneNumber: doc['phoneNumber'],
  bod: (doc['bod'] as Timestamp).toDate(),
  isOnline: doc['isOnline'],
  lastSeen: (doc['lastSeen'] as Timestamp).toDate(),
  signedAt: doc['signedAt'],
  );
  }


  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'username': username,
      'password': password,
      'bio': bio,
      'level': level,
      'sex': sex,
      'email': email,
      'profilePic': profilePic,
      'phoneNumber': phoneNumber,
      'bod': bod,
      'isOnline': isOnline,
      'lastSeen': lastSeen,
      'signedAt': signedAt,
    };
  }
}
