import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/helpers/custom_button.dart';
import 'package:uuid/uuid.dart';
import '../model/destination.dart';
import '../providers/destinations.dart';
import '../widgets/destination_image_picker.dart';


const List<String> destinationType = <String>['Place', 'Mountain', 'Lake', 'Waterfall'];
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
  List<File?> _destinationImageFile=[];
  var _isLoading = false;

  String dropdownValue = destinationType.first;

  var destinationItem = Destination(
    id: const Uuid().v4(),
    name: "",
    overview: "",
    region: "",
    type: "",
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
      if (_destinationImageFile.isNotEmpty) {
        Provider.of<Destinations>(context, listen: false)
            .saveData(destinationItem, _destinationImageFile);
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

  void pickedImage(List<XFile?> xFileList) {
    for (var xFile in xFileList){
      _destinationImageFile.add(File(xFile!.path));
    }
    // _userImageFile = File(file[0]!.path);
    if (_destinationImageFile.isNotEmpty) {
      destinationItem = Destination(
        id: destinationItem.id,
        name: destinationItem.name,
        overview: destinationItem.overview,
        region: destinationItem.region,
        type:dropdownValue,
        photo_url: [],
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
                      DropdownButton<String>(

                        value: dropdownValue,
                        icon: const Icon(Icons.arrow_downward),
                        elevation: 16,
                        style: const TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String? value) {
                          // This is called when the user selects an item.
                          print("VALUE");
                          print(value);
                          setState(() {
                            dropdownValue = value!;
                          });
                        },
                        items: destinationType
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      const SizedBox(
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
