import 'package:travel_app/model/dummy_data.dart';
import 'package:travel_app/model/review.dart';

class Destination {
  final int id;
  final String name;
  final Destination_Type type;
  final List<String> photos;
  final String region;
  final String overview;
  // final List<Review> reviews;

  Destination({
    required this.id,
    required this.name,
    required this.type,
    required this.photos,
    required this.region,
    required this.overview,
    // required this.reviews
  });
}
