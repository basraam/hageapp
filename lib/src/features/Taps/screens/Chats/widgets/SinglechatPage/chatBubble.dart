
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../../../../../data/models/singleChat_model.dart';
import '../../../../../../utils/firebase.dart';

class BChatBubble extends StatelessWidget {
  final SMessage message;

  BChatBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    RxBool isMe = message.userRef == firebaseAuth.currentUser!.uid ? true.obs : false.obs;

    return Obx(
          () => Align(
        alignment: isMe.value ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: isMe.value ? Colors.green : Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              const BoxShadow(
                color: Colors.black12,
                offset: Offset(0, 2),
                blurRadius: 4,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: isMe.value ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              if (message.contentText.isNotEmpty)
                Text(
                  message.contentText,
                  style: TextStyle(
                    color: isMe.value ? Colors.white : Colors.black,
                  ),
                ),
              if (message.contentImage.isNotEmpty)
                Image.network(
                  message.contentImage,
                  width: 150,
                  height: 150,
                ),
              if (message.contentVideo.isNotEmpty)
                VideoPlayerWidget(videoUrl: message.contentVideo),
              if (message.contentDocument.isNotEmpty)
                FileWidget(filePath: message.contentDocument),
              const SizedBox(height: 5),
              Text(
                message.timestamp.toString(),
                style: TextStyle(
                  color: isMe.value ? Colors.white : Colors.black,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  VideoPlayerWidget({required this.videoUrl});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl);
    _initializeVideoPlayerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class FileWidget extends StatelessWidget {
  final String filePath;

  FileWidget({required this.filePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          const Icon(Icons.description, size: 50, color: Colors.blue),
          const SizedBox(height: 5),
          const Text(
            'Document',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Text(
            filePath,
            style: const TextStyle(fontSize: 10, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}