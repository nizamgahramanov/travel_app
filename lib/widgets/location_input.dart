import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../helpers/location_helper.dart';
import '../screen/maps_screen.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectPlace;
  LocationInput(this.onSelectPlace);
  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;
  bool isSelecting = true;

  Future<void> _getCurrentUserLocation() async {
    print("GET CURRENT USER LOCATION");
    try {
      final locData = await Location().getLocation();
      showPreview(locData.latitude!, locData.longitude!);
      widget.onSelectPlace(locData.latitude, locData.longitude);
    } catch (error) {
      print(error.toString());
    }
  }

  Future<void> _selectOnMap() async {
    // final selectedLocation = await Navigator.of(context).push<LatLng>(
    //   MaterialPageRoute(
    //     fullscreenDialog: true,
    //     builder: (context) => MapScreen(
    //       isSelecting: true,
    //
    //     ),
    //   ),
    // );
    Map<String, dynamic> arguments = {
      "isSelecting": isSelecting,
      "geoPoint": const GeoPoint(40.35412015822521, 47.783417697006065),
      "zoom":7.0
    };
    final selectedLocation = await Navigator.of(context).pushNamed(
      MapScreen.routeName,
      arguments: arguments,
    ) as LatLng;
    if (selectedLocation == null) {
      return;
    }
    showPreview(selectedLocation.latitude, selectedLocation.longitude);
    widget.onSelectPlace(selectedLocation.latitude, selectedLocation.longitude);
  }

  void showPreview(double lat, double lng) {
    final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
        latitude: lat, longitude: lng);
    print("___________________________");
    print(staticMapImageUrl);
    setState(() {
      print(_previewImageUrl);
      _previewImageUrl = staticMapImageUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          width: double.infinity,
          child: _previewImageUrl == null
              ? const Text(
                  'No Location Chose',
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewImageUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          children: [
            OutlinedButton.icon(
              onPressed: _getCurrentUserLocation,
              icon: const Icon(Icons.location_on),
              label: const Text('Current Location'),
            ),
            OutlinedButton.icon(
              onPressed: _selectOnMap,
              icon: const Icon(Icons.map),
              label: const Text('Select on map'),
            ),
          ],
        )
      ],
    );
  }
}
