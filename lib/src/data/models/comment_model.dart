class CommentsModel {
  final String id;
  final String userId;
  final String fullName;
  final String username;
  final String profilePic;
  final String content;
  final DateTime createdDate;
  final int likes;
  final List<String> likedBy; // Add this field

  CommentsModel({
    required this.id,
    required this.userId,
    required this.fullName,
    required this.username,
    required this.profilePic,
    required this.content,
    required this.createdDate,
    required this.likes,
    required this.likedBy, // Initialize with an empty list in constructor
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'fullName': fullName,
    'username': username,
    'profilePic': profilePic,
    'content': content,
    'createdDate': createdDate.toIso8601String(),
    'likes': likes,
    'likedBy': likedBy,
  };

  static CommentsModel fromJson(Map<String, dynamic> json) => CommentsModel(
    id: json['id'],
    userId: json['userId'],
    fullName: json['fullName'],
    username: json['username'],
    profilePic: json['profilePic'],
    content: json['content'],
    createdDate: DateTime.parse(json['createdDate']),
    likes: json['likes'] ?? 0,
    likedBy: json['likedBy'] != null ? List<String>.from(json['likedBy']) : [],
  );
}
