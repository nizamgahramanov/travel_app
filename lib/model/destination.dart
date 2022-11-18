import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../helpers/destination_type.dart';

class Destination {
  final String? id;
  final String name;
  final String overview;
  final String region;
  final String type;
  final GeoPoint geoPoint;
  List<String> photoUrl;

  // final List<Review> reviews;

  Destination({
    required this.id,
    required this.name,
    required this.overview,
    required this.region,
    required this.type,
    required this.photoUrl,
    required this.geoPoint,
    // required this.reviews
  });
  Map<String, dynamic> createMap() {
    return {
      'id': id,
      'name': name,
      'overview': overview,
      'region': region,
      'type': type,
      'photo_url': photoUrl,
      'geoPoint':geoPoint
    };
  }

  Destination.fromFirestore(Map<String, dynamic> firestoreMap)
      : id = firestoreMap['id'],
        name = firestoreMap['name'],
        overview = firestoreMap['overview'],
        region = firestoreMap['region'],
        type = firestoreMap['type'],
        photoUrl = firestoreMap['photo_url'].cast<String>(),
        geoPoint = firestoreMap['geoPoint'];
}
