import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/chat_model.dart';
import '../../models/friends_model.dart';
import '../../models/singleChat_model.dart';
import '../../models/user_model.dart';

class ChatFirestoreRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // User operations
  Stream<List<UserModel>> getUsers() {
    return _firestore.collection('users').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => UserModel.fromSnapshot(doc)).toList();
    });
  }

  // Friend operations
  Stream<List<Friend>> getFriends(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('friends')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Friend.fromSnapshot(doc)).toList();
    });
  }

  // Chat operations
  Stream<List<Chat>> getChats(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('chats')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Chat.fromSnapshot(doc)).toList();
    });
  }

  // Message operations
  Stream<List<SMessage>> getMessages(String userId, String chatId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => SMessage.fromSnapshot(doc)).toList();
    });
  }

  Future<void> addMessage(String userId, String chatId, SMessage message) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .doc(message.id)
        .set(message.toMap());
  }

  DocumentReference getNewMessageDoc(String userId, String chatId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .doc();
  }

  DocumentReference getUserRef(String userId) {
    return _firestore.collection('users').doc(userId);
  }
}
