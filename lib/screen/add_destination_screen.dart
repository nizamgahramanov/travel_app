import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/helpers/custom_button.dart';
import 'package:uuid/uuid.dart';
import '../model/destination.dart';
import '../providers/destinations.dart';
import '../widgets/destination_image_picker.dart';

class AddDestinationScreen extends StatefulWidget {
  const AddDestinationScreen({Key? key}) : super(key: key);
  static const routeName = "/add_destination";
  @override
  State<AddDestinationScreen> createState() => _AddDestinationScreenState();
}

class _AddDestinationScreenState extends State<AddDestinationScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final overviewController = TextEditingController();
  final regionController = TextEditingController();
  final typeController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  File? _userImageFile;
  var _isLoading = false;
  var destinationItem = Destination(
    id: null,
    name: "",
    overview: "",
    region: "",
    type: null,
    photo_url: [],
  );

  void _saveForm() async {
    final isValid = _formKey.currentState!.validate();
    setState(() {
      _isLoading = true;
    });
    print(isValid);
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
    try {
      if (_userImageFile != null) {
        Provider.of<Destinations>(context, listen: false)
            .saveData(destinationItem, _userImageFile!);
      }
    } catch (error) {
      await showDialog<Null>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Sorry'),
          content: Text('Something went wrong'),
          actions: [
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Okay'),
            ),
          ],
        ),
      );
    }

    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
  }

  void pickedImage(XFile file) {
    _userImageFile = File(file.path);
    var uuid = Uuid();
    if (_userImageFile != null) {
      print(uuid.v4().toString());
      destinationItem = Destination(
        id: 9,
        name: destinationItem.name,
        overview: destinationItem.overview,
        region: destinationItem.region,
        type: destinationItem.type,
        photo_url: [_userImageFile!.path],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  height: MediaQuery.of(context).size.height * 1,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: nameController,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Destination';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          hintText: 'Enter Destination Name',
                        ),
                        onSaved: (value) {
                          destinationItem = Destination(
                            id: destinationItem.id,
                            name: value!,
                            overview: destinationItem.overview,
                            region: destinationItem.region,
                            type: destinationItem.type,
                            photo_url: destinationItem.photo_url,
                          );
                        },
                      ),
                      TextFormField(
                        controller: overviewController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Overview';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          hintText: 'Enter Destination Overview',
                        ),
                        onSaved: (value) {
                          destinationItem = Destination(
                            id: destinationItem.id,
                            name: destinationItem.name,
                            overview: value!,
                            region: destinationItem.region,
                            type: destinationItem.type,
                            photo_url: destinationItem.photo_url,
                          );
                        },
                      ),
                      TextFormField(
                        controller: regionController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Region';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          hintText: 'Enter Destination Region',
                        ),
                        onSaved: (value) {
                          destinationItem = Destination(
                            id: destinationItem.id,
                            name: destinationItem.name,
                            overview: destinationItem.overview,
                            region: value!,
                            type: destinationItem.type,
                            photo_url: destinationItem.photo_url,
                          );
                        },
                      ),
                      TextFormField(
                        controller: typeController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Type';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          hintText: 'Enter Destination Type',
                        ),
                        onSaved: (value) {
                          destinationItem = Destination(
                            id: destinationItem.id,
                            name: destinationItem.name,
                            overview: destinationItem.overview,
                            region: destinationItem.region,
                            type: destinationItem.type,
                            photo_url: destinationItem.photo_url,
                          );
                        },
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      DestinationImagePicker(pickedImage)
                    ],
                  ),
                ),
              ),
            )),
      ),
      floatingActionButton: CustomButton(
        onTap: _saveForm,
        buttonText: "SAVE",
        borderRadius: 25,
      ),
    );
  }
}
