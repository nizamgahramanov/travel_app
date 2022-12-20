import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travel_app/helpers/custom_button.dart';

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
    final List<XFile> selectedImages = await imagePicker.pickMultiImage(
      imageQuality: 100,
      maxWidth: 800,
      maxHeight: 800,
    );
    for (var selectedImageItem in selectedImages) {
      var a = await selectedImageItem.readAsBytes();
      var b = await decodeImageFromList(a);
      print("Selected Image Height And Width");
      print(b.height);
      print(b.width);
    }

    setState(() {
      if (selectedImages.isNotEmpty) {
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
        CustomButton(
          onTap: pickImage,
          buttonText: 'add_photo'.tr(),
          borderRadius: 15,
          buttonColor: Colors.transparent,
          textColor: Colors.black,
          borderColor: Colors.black,
          icon: Container(
            width: 22,
            height: 22,
            margin: const EdgeInsets.only(right: 25),
            child: const Icon(Icons.photo_camera),
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        Container(
          height: 80,
          width: double.maxFinite,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: pickedImages.length,
              itemBuilder: (BuildContext ctx, index) {
                return CircleAvatar(
                  radius: 42,
                  backgroundColor: Colors.grey,
                  child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.grey,
                      backgroundImage: pickedImages.isNotEmpty
                          ? FileImage(File(pickedImages[index]!.path))
                          : null),
                );
              }),
        ),
      ],
    );
  }
}
