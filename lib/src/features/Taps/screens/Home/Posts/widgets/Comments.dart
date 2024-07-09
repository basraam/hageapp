import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hage_mobile_app/src/data/reposotories/Posts/posts_repository.dart';
import 'package:hage_mobile_app/src/features/Taps/controllers/PostsController/PostsController.dart';
import 'package:hage_mobile_app/src/features/Taps/screens/Home/Posts/widgets/SingleComment_container.dart';
import 'package:hage_mobile_app/src/utils/constants/Colors.dart';

class CommentScreen extends StatelessWidget {
  final String postId;

  const CommentScreen({Key? key, required this.postId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PostController postController = Get.find<PostController>();

    // Fetch comments when screen is opened
    postController.fetchComments(postId);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Comments"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Obx(() {
                if (postController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (postController.commentsList.isEmpty) {
                  return const Center(child: Text("No comments yet."));
                }

                return ListView.builder(
                  itemCount: postController.commentsList.length,
                  itemBuilder: (context, index) {
                    final comment = postController.commentsList[index];

                    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                      future: FirebaseFirestore.instance.collection('users').doc(comment.userId).get(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        }

                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }

                        if (!snapshot.hasData || snapshot.data == null) {
                          return const Text('User not found');
                        }

                        final userData = snapshot.data!.data();
                        if (userData == null) {
                          return const Text('User data not available');
                        }

                        final username = userData['fullName'] as String;
                        final profilePic = userData['profilePic'] as String;

                        return SingleCommentContainer(
                          username: username,
                          profilePicture: profilePic,
                          postTime: comment.createdDate,
                          commentContent: comment.content,
                          likes: comment.likes,
                          commentId: comment.id,
                          isLiked: postController.isLikedByCurrentUser(comment.id),
                          onLike: () => postController.togglecommentLike(postId, comment.id),
                        );
                      },
                    );
                  },
                );
              }),
            ),
            const Divider(height: 20),
            Row(
              children: [
                Form(
                  key: postController.commentFormKey.value,
                  child: Expanded(
                    child: TextField(
                      controller: postController.commentContent.value,
                      decoration: const InputDecoration(
                        hintText: 'Write a comment...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    postController.addComment(postId);
                  },
                  child: const Text('send comment'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
