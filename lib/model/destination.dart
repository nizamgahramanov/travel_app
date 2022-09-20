import 'dart:io';

import '../helpers/destination_type.dart';

class Destination {
  final String? id;
  final String name;
  final String overview;
  final String region;
  final String type;
  List<String> photo_url;
  // final List<Review> reviews;

  Destination({
    required this.id,
    required this.name,
    required this.overview,
    required this.region,
    required this.type,
    required this.photo_url,
    // required this.reviews
  });
  Map<String, dynamic> createMap() {
    return {
      'id': id,
      'name': name,
      'overview': overview,
      'region': region,
      'type': type,
      'photo_url': photo_url,
    };
  }
  Destination.fromFirestore(Map<String, dynamic> firestoreMap)
      : id = firestoreMap['id'],
        name = firestoreMap['name'],
        overview = firestoreMap['overview'],
        region = firestoreMap['region'],
        type = firestoreMap['type'],
        photo_url = firestoreMap['photo_url'].cast<String>();


}
