import 'package:travel_app/model/dummy_data.dart';

class Destination {
  final String name;
  final Destination_Type type;
  final String image_url;
  final String region;
  Destination({
    required this.name,
    required this.type,
    required this.image_url,
    required this.region,
  });
}
