import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DestinationImagePicker extends StatefulWidget {
  DestinationImagePicker(this.imagePickFn);
  final void Function(List<XFile?> pickedImage) imagePickFn;

  @override
  State<DestinationImagePicker> createState() => _DestinationImagePickerState();
}

class _DestinationImagePickerState extends State<DestinationImagePicker> {
  List<XFile?> pickedImages = [];
  final ImagePicker imagePicker = ImagePicker();
  void pickImage() async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage(
      imageQuality: 90,
      maxWidth: 400,
      maxHeight: 400,
    );

    setState(() {
      if (selectedImages!.isNotEmpty) {
        pickedImages.addAll(selectedImages);
      }
    });
    widget.imagePickFn(pickedImages);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(height: 200,
          width: 300,
          child: ListView.builder(
              itemCount: pickedImages.length,
              itemBuilder: (BuildContext ctx, index) {
                return CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey,
                    backgroundImage: pickedImages.isNotEmpty
                        ? FileImage(File(pickedImages[index]!.path))
                        : null);
              }),
        ),
        // CircleAvatar(
        //   radius: 40,
        //   backgroundColor: Colors.grey,
        //   backgroundImage:
        //   pickedImages.isNotEmpty  ? FileImage(File(pickedImages[1]!.path)) : null,
        // ),
        OutlinedButton.icon(
          onPressed: pickImage,
          icon: const Icon(Icons.image),
          label: const Text("Add image"),
        ),
      ],
    );
  }
}
