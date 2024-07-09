// import 'dart:io';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get/get.dart';
// import 'package:hage_mobile_app/src/data/models/post_model.dart';
// import 'package:uuid/uuid.dart';
//
// import '../../models/user_model.dart';
// // Adjust import based on your util/firebase.dart location
//
// class PostController extends GetxController {
//   final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
//   final CollectionReference usersRef = FirebaseFirestore.instance.collection('users');
//   final CollectionReference postRef = FirebaseFirestore.instance.collection('posts');
//   final CollectionReference commentRef = FirebaseFirestore.instance.collection('comments');
//   final CollectionReference notificationRef = FirebaseFirestore.instance.collection('notifications');
//   final String profilePic = 'profilePic';
//   final String posts = 'posts';
//   final Uuid uuid = const Uuid();
//   late UserModel user;
//
//   // Uploads profile picture to the users collection
//   Future<void> uploadProfilePicture(File image, UserModel user) async {
//     String link = await uploadImage(profilePic, image);
//     var ref = usersRef.doc(user.id); // Assuming UserModel has an 'id' field
//     await ref.update({
//       "photoUrl": link,
//     });
//   }
//
//   // Uploads post to the post collection
//   Future<void> uploadPost(File image, String description) async {
//     String link = await uploadImage(posts, image);
//     DocumentSnapshot doc = await usersRef.doc(firebaseAuth.currentUser!.uid).get();
//     user = UserModel.fromSnapshot(doc); // Using fromSnapshot here
//     var ref = postRef.doc();
//     await ref.set({
//       "id": ref.id,
//       "postId": ref.id,
//       "authorId": firebaseAuth.currentUser!.uid,
//       "authorName": user.username,
//       "authorProfilePicture": user.profilePic,
//       "postImage": link, // Corrected syntax
//       "": description ?? "",
//       "likes": [], // Assuming 'likes' is a list of user IDs who liked the post
//       "createdDate": Timestamp.now(),
//     }).catchError((e) {
//       print(e);
//     });
//   }
//
//   // Upload a comment
//   Future<void> uploadComment(String currentUserId, String comment, String postId,
//       String ownerId, String mediaUrl) async {
//     DocumentSnapshot doc = await usersRef.doc(currentUserId).get();
//     user = UserModel.fromSnapshot(doc); // Using fromSnapshot here
//     await commentRef.doc(postId).collection("comments").add({
//       "username": user.username,
//       "comment": comment,
//       "timestamp": Timestamp.now(),
//       "userDp": user.profilePic,
//       "userId": user.id,
//     });
//     bool isNotMe = ownerId != currentUserId;
//     if (isNotMe) {
//       addCommentToNotification("comment", comment, user.username, user.id,
//           postId, mediaUrl, ownerId, user.profilePic); // Adjust user.photoUrl based on your UserModel
//     }
//   }
//
//   // Add the comment to notification collection
//   Future<void> addCommentToNotification(
//       String type,
//       String commentData,
//       String username,
//       String userId,
//       String postId,
//       String mediaUrl,
//       String ownerId,
//       String userDp) async {
//     await notificationRef.doc(ownerId).collection('notifications').add({
//       "type": type,
//       "commentData": commentData,
//       "username": username,
//       "userId": userId,
//       "userDp": userDp,
//       "postId": postId,
//       "mediaUrl": mediaUrl,
//       "timestamp": Timestamp.now(),
//     });
//   }
//
//   // Add the likes to the notification collection
//   Future<void> addLikesToNotification(String type, String username, String userId,
//       String postId, String mediaUrl, String ownerId, String userDp) async {
//     await notificationRef
//         .doc(ownerId)
//         .collection('notifications')
//         .doc(postId)
//         .set({
//       "type": type,
//       "username": username,
//       "userId": firebaseAuth.currentUser!.uid,
//       "userDp": userDp,
//       "postId": postId,
//       "mediaUrl": mediaUrl,
//       "timestamp": Timestamp.now(),
//     });
//   }
//
//   // Remove likes from notification
//   Future<void> removeLikeFromNotification(
//       String ownerId, String postId, String currentUser) async {
//     bool isNotMe = currentUser != ownerId;
//
//     if (isNotMe) {
//       DocumentSnapshot doc = await usersRef.doc(currentUser).get();
//       user = UserModel.fromSnapshot(doc); // Using fromSnapshot here
//       notificationRef
//           .doc(ownerId)
//           .collection('notifications')
//           .doc(postId)
//           .get()
//           .then((doc) => {
//         if (doc.exists) {doc.reference.delete()}
//       });
//     }
//   }
//
//   // Dummy function for uploading image to Firebase Storage
//   Future<String> uploadImage(String path, File image) async {
//     // Implement your logic to upload image and return the URL
//     return "https://example.com/image.jpg";
//   }
//
//   // Get all posts from Firestore
//   Stream<List<PostsModel>> getPosts() {
//     return postRef.snapshots().map((snapshot) =>
//         snapshot.docs.map((doc) => PostsModel.fromSnapshot(doc)).toList());
//   }
// }
