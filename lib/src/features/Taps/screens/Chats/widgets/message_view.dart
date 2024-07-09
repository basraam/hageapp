import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hage_mobile_app/src/common/custom_shapes/containers/ProfileImage_container.dart';
import 'package:hage_mobile_app/src/utils/constants/BSizes.dart';
import 'package:hage_mobile_app/src/utils/constants/images.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Add Firestore import

import 'package:hage_mobile_app/src/data/models/singleChat_model.dart'; // Assuming this is where SMessage is imported from
import 'package:hage_mobile_app/src/utils/constants/Colors.dart';
import 'package:hage_mobile_app/src/utils/firebase.dart';

import 'SinglechatPage/chatBubble.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<SMessage> messages = [];
  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchMessages();
  }

  Future<void> _fetchMessages() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .get();

    setState(() {
      messages = querySnapshot.docs
          .map((doc) => SMessage.fromSnapshot(doc))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F7F7),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.green),
          onPressed: () => Get.back(),
        ),
        title: Row(
          children: [
            const BProfileImage(
              image: BImages.profilePicture, // Replace with your image asset
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Username', // Replace with actual username
                  style: const TextStyle(color: Colors.black),
                ),
                Text(
                  'Online', // Replace with actual status
                  style: const TextStyle(color: Colors.green, fontSize: 12),
                ),
              ],
            )
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.videocam, color: Colors.green),
            onPressed: () {
              // Implement video call functionality
            },
          ),
          IconButton(
            icon: const Icon(Icons.call, color: Colors.green),
            onPressed: () {
              // Implement voice call functionality
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: BSizes.sm),
          const Center(
            child: Text(
              'Today', // Replace with actual date
              style: TextStyle(color: BColors.secondaryColor),
            ),
          ),
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return BChatBubble(message: message);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.attach_file, color: Colors.black),
                  onPressed: () => _pickFile(context),
                ),
                Expanded(
                  child: TextField(
                    controller: _textEditingController,
                    decoration: InputDecoration(
                      hintText: 'Type here.....',
                      filled: true,
                      fillColor: Colors.grey[300],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.mic, color: Colors.black),
                  onPressed: () {
                    // Implement voice message recording
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.black),
                  onPressed: () {
                    _sendMessage(_textEditingController.text.trim());
                    _textEditingController.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage(String text) async {
    if (text.isNotEmpty) {
      final usersRef = FirebaseFirestore.instance.collection('users');
      SMessage newMessage = SMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        userRef: usersRef.doc(firebaseAuth.currentUser?.uid),
        contentText: text,
        contentImage: '',
        contentVideo: '',
        contentDocument: '',
        timestamp: DateTime.now(),
      );

      setState(() {
        messages.insert(0, newMessage);
      });

      await FirebaseFirestore.instance.collection('messages').add(newMessage.toMap());

      _textEditingController.clear();
    }
  }

  Future<void> _pickFile(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc', 'mp4'],
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      // TODO: Handle file upload to Firebase Storage and message sending with file URL
    }
  }

  Future<void> _pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // TODO: Handle image upload to Firebase Storage and message sending with image URL
    }
  }
}
