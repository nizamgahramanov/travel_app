import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../helpers/destination_type.dart';

class Destination {
  final String? id;
  final String name;
  final String overview;
  final String? overviewAz;
  final String region;
  final String? regionAz;
  final String type;
  final GeoPoint geoPoint;
  List<dynamic> photoUrl;

  Destination({
    required this.id,
    required this.name,
    required this.overview,
    this.overviewAz,
    required this.region,
    this.regionAz,
    required this.type,
    required this.photoUrl,
    required this.geoPoint,
  });
  Map<String, dynamic> createMap() {
    return {
      'id': id,
      'name': name,
      'overview': overview,
      'region': region,
      'type': type,
      'photo_url': photoUrl,
      'geoPoint': geoPoint
    };
  }

  Destination.fromFirestore(Map<String, dynamic> firestoreMap)
      : id = firestoreMap['id'],
        name = firestoreMap['name'],
        overview = firestoreMap['overview'],
        overviewAz = firestoreMap['overviewAz'],
        region = firestoreMap['region'],
        regionAz = firestoreMap['regionAz'],
        type = firestoreMap['type'],
        photoUrl = firestoreMap['photo_url'].cast<String>(),
        geoPoint = firestoreMap['geoPoint'];
}
