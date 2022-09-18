import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DestinationImagePicker extends StatefulWidget {
  DestinationImagePicker(this.imagePickFn);
  final void Function(XFile pickedImage) imagePickFn;

  @override
  State<DestinationImagePicker> createState() => _DestinationImagePickerState();
}

class _DestinationImagePickerState extends State<DestinationImagePicker> {
  XFile? pickedImage;
  void pickImage() async {
    final pickedImageFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
    );
    setState(() {
      pickedImage = pickedImageFile;
    });
    widget.imagePickFn(pickedImage!);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage:
          pickedImage != null ? FileImage(File(pickedImage!.path)) : null,
        ),
        OutlinedButton.icon(
          onPressed: pickImage,
          icon: const Icon(Icons.image),
          label: const Text("Add image"),
        ),
      ],
    );
  }
}