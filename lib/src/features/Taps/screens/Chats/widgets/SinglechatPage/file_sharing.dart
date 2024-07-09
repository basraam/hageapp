import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<void> _pickFile(BuildContext context) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['jpg', 'pdf', 'doc', 'mp4'],
  );

  if (result != null) {
    PlatformFile file = result.files.first;
    // TODO: Handle file upload to Firebase Storage and message sending with file URL
  } else {
    // User canceled the picker
  }
}

Future<void> _pickImage(BuildContext context) async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);

  if (pickedFile != null) {
    // TODO: Handle image upload to Firebase Storage and message sending with image URL
  } else {
    // User canceled the picker
  }
}
