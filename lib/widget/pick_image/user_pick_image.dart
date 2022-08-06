import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserPickImage extends StatefulWidget {
  const UserPickImage({Key? key}) : super(key: key);

  @override
  State<UserPickImage> createState() => _UserPickImageState();
}

class _UserPickImageState extends State<UserPickImage> {
  File? _imgFile;

  void _pickImage() async {
    final _pick = ImagePicker();

    final imageData = await _pick.pickImage(source: ImageSource.camera);
    setState(() {
      _imgFile = File(imageData!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.grey,
          backgroundImage: _imgFile != null ? FileImage(_imgFile!) : null,
          radius: 40,
        ),
        TextButton.icon(
          onPressed: _pickImage,
          icon: Icon(Icons.camera),
          label: Text('Pick Image'),
        ),
      ],
    );
  }
}
