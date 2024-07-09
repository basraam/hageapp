import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hage_mobile_app/src/utils/constants/images.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../../../../utils/constants/BSizes.dart';
import '../../../../../utils/constants/Colors.dart';

class CreateNewGroupPage extends StatefulWidget {
  @override
  _CreateNewGroupPageState createState() => _CreateNewGroupPageState();
}

class _CreateNewGroupPageState extends State<CreateNewGroupPage> {
  final _formKey = GlobalKey<FormState>();
  final _groupNameController = TextEditingController();
  final _groupTagController = TextEditingController();
  final _descriptionController = TextEditingController();
  File? _imageFile;
  String _groupType = 'Koox guud';

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _createGroup() async {
    if (_formKey.currentState!.validate() && _imageFile != null) {
      // Upload the image to a storage service and get the URL
      String imageUrl = await _uploadImage(_imageFile!);

      // Add group to Firestore
      await FirebaseFirestore.instance.collection('Groups').add({
        'groupName': _groupNameController.text,
        'groupTag': _groupTagController.text,
        'description': _descriptionController.text,
        'groupCoverImage': imageUrl,
        'createdAt': Timestamp.now(),
        'membersCount': 1, // Initial member count
        'groupType': _groupType,
      });

      // Go back to previous screen
      Get.back();
    }
  }

  Future<String> _uploadImage(File image) async {
    // Simulate an upload image function
    // In reality, you need to use Firebase Storage or another service
    await Future.delayed(const Duration(seconds: 1));
    return image.path;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Abuur Koox cusub'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: _imageFile != null
                        ? FileImage(_imageFile!)
                        : const AssetImage(BImages.groupProfile)
                    as ImageProvider,
                  ),
                ),
                TextButton(
                  onPressed: _pickImage,
                  child: const Text('Dooro Sawirka Kooxda',
                      style:
                      TextStyle(color: BColors.primaryColor, fontSize: 16)),
                ),
                const SizedBox(height: BSizes.spaceBtwItems),
                TextFormField(
                  controller: _groupNameController,
                  decoration: const InputDecoration(labelText: 'Magaca Kooxda'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Fadlan geli magaca kooxda';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: BSizes.spaceBtwItems),
                TextFormField(
                  controller: _groupTagController,
                  decoration:
                  const InputDecoration(labelText: 'Astaanta kooxda'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Fadlan geli astaanta kooxda';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: BSizes.spaceBtwItems),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(labelText: 'Warbixin'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Fadlan geli warbixin ku saabsan kooxda';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: BSizes.spaceBtwInputFields),
                DropdownButtonFormField<String>(
                  value: _groupType,
                  decoration: const InputDecoration(labelText: 'Nooca Kooxda'),
                  items: <String>['Koox guud', 'koox gaar ah']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _groupType = newValue!;
                    });
                  },
                ),
                const SizedBox(height: BSizes.spaceBtwInputFields),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: _createGroup,
                    child: const Text('Abuur Koox cusub'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
