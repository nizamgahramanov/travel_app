import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/helpers/custom_button.dart';
import 'package:travel_app/model/destination_location.dart';
import 'package:uuid/uuid.dart';
import '../helpers/utility.dart';
import '../model/destination.dart';
import '../providers/destinations.dart';
import '../widgets/destination_image_picker.dart';
import '../widgets/location_input.dart';

const List<String> destinationType = <String>[
  'place',
  'mountain',
  'lake',
  'waterfall'
];

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
  List<File?> _destinationImageFile = [];
  DestinationLocation? _destinationLocation;
  var _isLoading = false;

  String dropdownValue = destinationType.first;

  var destinationItem = Destination(
    id: const Uuid().v4(),
    name: "",
    overview: "",
    region: "",
    type: "",
    photo_url: [],
    geoPoint: const GeoPoint(40.6079186, 49.5886951),
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
      if (_destinationImageFile.isNotEmpty &&
          _destinationLocation?.latitude != null) {
        destinationItem = Destination(
            id: destinationItem.id,
            name: destinationItem.name,
            overview: destinationItem.overview,
            region: destinationItem.region,
            type: dropdownValue,
            photo_url: [],
            geoPoint: GeoPoint(_destinationLocation!.latitude,
                _destinationLocation!.longitude));
        Provider.of<Destinations>(context, listen: false)
             .saveData(destinationItem, _destinationImageFile);
      }
    } catch (error) {
      Utility.getInstance().showAlertDialog(
          context: context,
          alertTitle: "Something went wrong",
          popButtonText: "Ok",
          onPopTap: () => Navigator.of(context).pop());
    }

    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
  }

  void pickedImage(List<XFile?> xFileList) {
    for (var xFile in xFileList) {
      _destinationImageFile.add(File(xFile!.path));
    }
    // _userImageFile = File(file[0]!.path);
  }

  void _selectPlace(double lat, double lng) {
    print(lat.toString());
    _destinationLocation = DestinationLocation(latitude: lat, longitude: lng);
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
                              geoPoint: destinationItem.geoPoint);
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
                              geoPoint: destinationItem.geoPoint);
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
                              geoPoint: destinationItem.geoPoint);
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
                      DestinationImagePicker(pickedImage),
                      LocationInput(_selectPlace),
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
