import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hage_mobile_app/src/data/reposotories/Posts/posts_repository.dart';
import 'package:hage_mobile_app/src/utils/firebase.dart';
import '../../../../data/models/comment_model.dart';
import '../../../../data/models/post_model.dart';

class PostController extends GetxController {
  final PostsRepository _repository = PostsRepository();
  var postsList = <PostsModel>[].obs;
  var postLists = <PostsModel>[].obs;
  var commentsList = <CommentsModel>[].obs;
  var isLoading = false.obs;
  var commentFormKey = GlobalKey<FormState>().obs;
  var commentContent = TextEditingController().obs;

  @override
  void onInit() {
    super.onInit();
    fetchUsersPosts();
  }

  Future<void> fetchUsersPosts() async {
    try {
      isLoading.value = true;
      print("Fetching posts...");
      List<PostsModel> posts = await _repository.fetchAllPosts();
      if (posts.isNotEmpty) {
        print("Posts fetched: ${posts.length}");
        postsList.value = posts;
      } else {
        print("No posts found");
        postsList.clear();
      }
    } catch (e) {
      print("Error fetching posts: $e");
      postsList.clear();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchUserPosts(String userId) async {
    try {
      isLoading.value = true;
      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('posts')
          .orderBy('createdDate', descending: true)
          .get();

      postLists.value = querySnapshot.docs
          .map((doc) => PostsModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch posts: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addComment(String postId) async {
    if (commentFormKey.value.currentState!.validate()) {
      final user = FirebaseAuth.instance.currentUser!;
      final userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      final fullName = userData['fullName'];
      final username = userData['username'];
      final profilePic = userData['profilePic'];

      final comment = CommentsModel(
          id: '',
          userId: user.uid,
          fullName: fullName,
          username: username,
          profilePic: profilePic,
          content: commentContent.value.text,
          createdDate: DateTime.now(),
          likes: 0,
          likedBy: []);

      await _repository.addComment(postId, comment);
      commentContent.value.clear();
      fetchComments(postId);
    }
  }

  Future<void> fetchComments(String postId) async {
    isLoading.value = true;
    try {
      commentsList.value = await _repository.fetchComments(postId);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> togglepostLike( String postId) async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await _repository.togglePostLike( postId, user.uid);
    } catch (e) {
      print("Error toggling like: $e");
    }
  }
  Future<void> togglecommentLike(String postId, String commentId) async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await _repository.toggleCommentLike(postId, commentId, user.uid);
      await fetchComments(postId);
    } catch (e) {
      print("Error toggling like: $e");
    }
  }

  bool PostisLikedByCurrentUser(String postId) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return false;

    // Find the comment in commentsList with matching commentId
    final post = postLists.firstWhere(
      (post) => post.id == postId,
      orElse: () => PostsModel(
        id: '',
        fullName: '',
        username: '',
        profilePic: '',
        content: '',
        createdDate: DateTime.now(),
        likes: 0,
        likedBy: [],
        postImage: '',
        postVideo: '', // Ensure likedBy list is initialized properly
      ),
    );
    // Check if current user's id is in likedBy list of the comment
    return post.likedBy.contains(user.uid);
  }


  bool isLikedByCurrentUser(String commentId) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return false;

    // Find the comment in commentsList with matching commentId
    final comment = commentsList.firstWhere(
      (comment) => comment.id == commentId,
      orElse: () => CommentsModel(
        id: '',
        userId: '',
        fullName: '',
        username: '',
        profilePic: '',
        content: '',
        createdDate: DateTime.now(),
        likes: 0,
        likedBy: [], // Ensure likedBy list is initialized properly
      ),
    );

    // Check if current user's id is in likedBy list of the comment
    return comment.likedBy.contains(user.uid);
  }

  Future<void> removePost(String username, String postId) async {
    isLoading.value = true;
    try {
      await _repository.removePost(username, postId);
      await fetchUsersPosts();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> likePost(String username, String postId, String userId) async {
    isLoading.value = true;
    try {
      await _repository.likePost(username, postId, userId);
      await fetchUsersPosts();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteComment(
      String username, String postId, String commentId) async {
    isLoading.value = true;
    try {
      await _repository.deleteComment(username, postId, commentId);
    } finally {
      isLoading.value = false;
    }
  }

// Future<void> likeComment(String username, String postId, String commentId, String userId) async {
//   isLoading.value = true;
//   try {
//     await _repository.likeComment(username, postId, commentId, userId);
//   } finally {
//     isLoading.value = false;
//   }
// }
}
