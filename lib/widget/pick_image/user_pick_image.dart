import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserPickImage extends StatefulWidget {
  final void Function(File imgFile) pickImg;

  const UserPickImage(this.pickImg, {Key? key}) : super(key: key);

  @override
  State<UserPickImage> createState() => _UserPickImageState();
}

class _UserPickImageState extends State<UserPickImage> {
  File? _imgFile;

  void _pickImage() async {
    final _pick = ImagePicker();

    final imageData = await _pick.pickImage(
      source: ImageSource.camera,
      imageQuality: 60,
      maxWidth: 300,
    );
    setState(() {
      _imgFile = File(imageData!.path);
    });
    widget.pickImg(_imgFile!);
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
