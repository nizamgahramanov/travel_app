import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  // final DestinationLocation? initialLocation;
  final bool isSelecting;
  static const routeName = "/map_screen";
  // this.initialLocation =
  // const DestinationLocation(latitude: 40.6079186, longitude: 49.5886951)
  MapScreen(
      {this.isSelecting = false});
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedLocation;
  void _selectLocation(LatLng position) {
    print("SELECT LOCATION");
    print(position.longitude);
    setState(() {
      _pickedLocation = position;
    });
  }


  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)?.settings.arguments as Map<String,dynamic>;
    final geoPointArgument = data['geoPoint'] as GeoPoint;
    print(data);
    print(geoPointArgument);
    return Scaffold(
      appBar: AppBar(
        title: Text(data['name']),
        actions: [
          if (data["isSelecting"])
            IconButton(
              onPressed: _pickedLocation == null
                  ? null
                  : () {
                Navigator.of(context).pop(_pickedLocation);
              },
              icon: const Icon(Icons.check),
            ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(geoPointArgument.latitude,geoPointArgument.longitude),
          zoom: data['zoom'],
        ),
        onTap: data['isSelecting'] ? _selectLocation : null,
        markers: (_pickedLocation == null && data['isSelecting'] == true)
            ? {}
            : {
          Marker(
            markerId: const MarkerId('m1'),
            position: _pickedLocation ??
                LatLng(geoPointArgument.latitude,geoPointArgument.longitude),
          ),
        },
      ),
    );
  }
}
