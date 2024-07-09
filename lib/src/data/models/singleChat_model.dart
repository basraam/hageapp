import 'package:cloud_firestore/cloud_firestore.dart';

class SMessage {
  final String id;
  final DocumentReference userRef;
  final String contentText;
  String contentImage;
  String contentVideo;
  String contentDocument;
  final DateTime timestamp;

  SMessage({
    required this.id,
    required this.userRef,
    required this.contentText,
    required this.contentImage,
    required this.contentVideo,
    required this.contentDocument,
    required this.timestamp,
  });

  factory SMessage.fromSnapshot(DocumentSnapshot doc) {
    return SMessage(
      id: doc.id,
      userRef: doc['userRef'],
      contentText: doc['contentText'] ?? '',
      contentImage: doc['contentImage'] ?? '',
      contentVideo: doc['contentVideo'] ?? '',
      contentDocument: doc['contentDocument'] ?? '',
      timestamp: (doc['timestamp'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userRef': userRef,
      'contentText': contentText,
      'contentImage': contentImage,
      'contentVideo': contentVideo,
      'contentDocument': contentDocument,
      'timestamp': timestamp,
    };
  }
}
