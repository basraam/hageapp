import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class PostsModel {
  final String id;
  final String fullName;
  final String username;
  final String profilePic;
  final String content;
   String postImage;
   String postVideo;
  final DateTime createdDate;
  final int likes;
  final List<String> likedBy; // Add this field

  PostsModel({
    required this.id,
    required this.fullName,
    required this.username,
    required this.profilePic,
    required this.content,
    required this.postImage,
    required this.postVideo,
    required this.createdDate,
    required this.likes,
    required this.likedBy, // Initialize with an empty list in constructor

  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'fullName': fullName,
    'username': username,
    'profilePic': profilePic,
    'content': content,
    'postImage': postImage,
    'postVideo': postVideo,
    'createdDate': createdDate.toIso8601String(),
    'likes': likes,
    'likedBy': likedBy,

  };

  static PostsModel fromJson(Map<String, dynamic> json) => PostsModel(
    id: json['id'] ?? '',
    fullName: json['fullName'] ?? '',
    username: json['username']?? '',
    profilePic: json['profilePic']?? '',
    content: json['content']?? '',
    postImage: json['postImage']?? '',
    postVideo: json['postVideo']?? '',
    createdDate: (json['createdDate'] as Timestamp).toDate(),
    likes: json['likes']?? 0,
    likedBy: json['likedBy'] != null ? List<String>.from(json['likedBy']) : [],

  );
}

