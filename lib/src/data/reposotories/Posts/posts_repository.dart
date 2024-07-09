import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../models/comment_model.dart';
import '../../models/post_model.dart';

class PostsRepository {

  var postsList = <PostsModel>[].obs;
  var commentsList = <CommentsModel>[].obs;
  var isLoading = false.obs;
  var commentFormKey = GlobalKey<FormState>().obs;
  var commentContent = TextEditingController().obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadFile(File file, String path) async {
    try {
      final ref = _storage.ref().child(path);
      final uploadTask = await ref.putFile(file);
      return await uploadTask.ref.getDownloadURL();
    } catch (e) {
      print("File upload error: $e");
      throw e;
    }
  }

  Future<void> addPost(PostsModel post, String userId, {File? imageFile, File? videoFile}) async {
    try {
      if (imageFile != null) {
        post.postImage = await uploadFile(imageFile, 'posts/images/${DateTime.now().millisecondsSinceEpoch}');
      }

      if (videoFile != null) {
        post.postVideo = await uploadFile(videoFile, 'posts/videos/${DateTime.now().millisecondsSinceEpoch}');
      }

      final docRef = _firestore.collection('users').doc(userId).collection('posts').doc();
      await docRef.set({
        'id': docRef.id,
        'fullName': post.fullName,
        'username': post.username,
        'profilePic': post.profilePic,
        'content': post.content,
        'postImage': post.postImage,
        'postVideo': post.postVideo,
        'createdDate': post.createdDate,
        'likes': post.likes,
      });
    } catch (e) {
      print("Error adding post: $e");
      throw e;
    }
  }


// Future<void> addPost(PostsModel post, String userId) async {
  //   final docRef = _firestore.collection('users').doc(userId).collection('posts').doc();
  //   await docRef.set({
  //     'id': docRef.id,
  //     'fullName': post.fullName,
  //     'username': post.username,
  //     'profilePic': post.profilePic,
  //     'content': post.content,
  //     'postImage': post.postImage,
  //     'postVideo': post.postVideo,
  //     'createdDate': post.createdDate,
  //     'likes': post.likes,
  //   });
  // }

  Future<String?> uploadImage(File image) async {
    try {
      final storageRef = FirebaseStorage.instance.ref();
      final imagesRef = storageRef.child('Users/Images/${image.path.split('/').last}');
      final uploadTask = imagesRef.putFile(image);
      final snapshot = await uploadTask.whenComplete(() => null);
      final downloadURL = await snapshot.ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }


  Future<List<PostsModel>> fetchAllPosts() async {
    final snapshot = await _firestore.collectionGroup('posts').get();
    return snapshot.docs.map((doc) {
      final data = doc.data();
      // Check if createdDate is a Timestamp and convert to DateTime
      DateTime createdDate;
      if (data['createdDate'] is Timestamp) {
        createdDate = (data['createdDate'] as Timestamp).toDate();
      } else {
        createdDate = DateTime.parse(data['createdDate']);
      }
      return PostsModel(
        id: doc.id,
        fullName: data['fullName'],
        username: data['username'],
        profilePic: data['profilePic'],
        content: data['content'],
        postImage: data['postImage'],
        postVideo: data['postVideo'],
        createdDate: createdDate,
        likes: data['likes'],
        likedBy: [],
      );
    }).toList();
  }



  Future<void> editPost(String username, PostsModel post) async {
    await _firestore
        .collection('users')
        .doc(username)
        .collection('posts')
        .doc(post.id)
        .update(post.toJson());
  }

  Future<void> removePost(String username, String postId) async {
    await _firestore.collection('users').doc(username).collection('posts').doc(
        postId).delete();
  }

  Future<void> likePost(String username, String postId, String userId) async {
    DocumentReference postRef = _firestore
        .collection('users')
        .doc(username)
        .collection('posts')
        .doc(postId);

    await _firestore.runTransaction((transaction) async {
      DocumentSnapshot postSnapshot = await transaction.get(postRef);

      if (!postSnapshot.exists) {
        throw Exception("Post does not exist!");
      }

      List<String> likes = List<String>.from(postSnapshot['likes']);
      if (likes.contains(userId)) {
        likes.remove(userId);
      } else {
        likes.add(userId);
      }

      transaction.update(postRef, {'likes': likes});
    });
  }


  Future<void> addComment(String postId, CommentsModel comment) async {
    await _firestore.collection('posts').doc(postId)
        .collection('comments')
        .add({
      'userId': comment.userId,
      'fullName': comment.fullName,
      'username': comment.username,
      'profilePic': comment.profilePic,
      'content': comment.content,
      'createdDate': comment.createdDate,
      'likes': comment.likes,
    });
  }

  Future<List<CommentsModel>> fetchComments(String postId) async {
    final snapshot = await _firestore.collection('posts')
        .doc(postId)
        .collection('comments')
        .orderBy('createdDate', descending: true)
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      return CommentsModel(
        id: doc.id,
        userId: data['userId'],
        fullName: data['fullName'],
        username: data['username'],
        profilePic: data['profilePic'],
        content: data['content'],
        createdDate: DateTime.parse(data['createdDate']),
        likes: data['likes'],
        likedBy: List<String>.from(data['likedBy']),

      );
    }).toList();
  }

  // Future<void> updateLike(String postId, String commentId, String userId) async {
  //   final commentRef = _firestore.collection('posts').doc(postId).collection('comments').doc(commentId);
  //
  //   // Use a transaction to ensure atomicity
  //   await _firestore.runTransaction((transaction) async {
  //     final snapshot = await transaction.get(commentRef);
  //     if (!snapshot.exists) {
  //       throw Exception("Comment does not exist!");
  //     }
  //
  //     // Get the current likes
  //     final data = snapshot.data()!;
  //     final currentLikes = data['likes'] as int;
  //
  //     // Increment the likes
  //     transaction.update(commentRef, {
  //       'likes': currentLikes + 1,
  //     });
  //   });
  // }

  Future<void> togglePostLike(String postId, String userId) async {
    final commentRef = _firestore.collection('posts').doc(postId);

    final snapshot = await commentRef.get();
    if (!snapshot.exists) {
      throw Exception("Comment does not exist!");
    }

    final data = snapshot.data()!;
    final currentLikes = data['likes'] as int;
    final List<String> likedBy = List<String>.from(data['likedBy'] ?? []);

    if (likedBy.contains(userId)) {
      likedBy.remove(userId); // Unlike if already liked
    } else {
      likedBy.add(userId); // Like if not liked
    }

    await commentRef.update({
      'likes': likedBy.length,
      'likedBy': likedBy,
    });
  }


  Future<void> toggleCommentLike(String postId, String commentId, String userId) async {
    final commentRef = _firestore.collection('posts').doc(postId).collection('comments').doc(commentId);

    final snapshot = await commentRef.get();
    if (!snapshot.exists) {
      throw Exception("Comment does not exist!");
    }

    final data = snapshot.data()!;
    final currentLikes = data['likes'] as int;
    final List<String> likedBy = List<String>.from(data['likedBy'] ?? []);

    if (likedBy.contains(userId)) {
      likedBy.remove(userId); // Unlike if already liked
    } else {
      likedBy.add(userId); // Like if not liked
    }

    await commentRef.update({
      'likes': likedBy.length,
      'likedBy': likedBy,
    });
  }


  Future<void> deleteComment(String username, String postId, String commentId) async {
    await _firestore
        .collection('users')
        .doc(username)
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(commentId)
        .delete();
  }

  Future<List<CommentsModel>> fetchPostComments(String username, String postId) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('users')
        .doc(username)
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .get();
    return querySnapshot.docs.map((doc) =>
        CommentsModel.fromJson(doc.data() as Map<String, dynamic>)).toList();
  }

  Future<void> likeComment(String username, String postId, String commentId, String userId) async {
    DocumentReference commentRef = _firestore
        .collection('users')
        .doc(username)
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(commentId);

    await _firestore.runTransaction((transaction) async {
      DocumentSnapshot commentSnapshot = await transaction.get(commentRef);

      if (!commentSnapshot.exists) {
        throw Exception("Comment does not exist!");
      }

      List<String> likes = List<String>.from(commentSnapshot['likes']);
      if (likes.contains(userId)) {
        likes.remove(userId);
      } else {
        likes.add(userId);
      }

      transaction.update(commentRef, {'likes': likes});
    });
  }

}
