import 'package:travel_app/model/destination.dart';

enum Destination_Type { waterwall, lake, historicalplace, forest }

List<Destination> destinations = [
  Destination(
    name: "Nohur Lake",
    type: Destination_Type.lake,
    image_url: 'https://picsum.photos/250?image=9',
    region: "Ismayilli",
  ),
  Destination(
    name: "Mamir shelalesi",
    type: Destination_Type.waterwall,
    image_url: 'https://picsum.photos/250?image=9',
    region: "Qax",
  ),
  Destination(
    name: "Qiz qalasi",
    type: Destination_Type.historicalplace,
    image_url: 'https://picsum.photos/250?image=9',
    region: "Baki",
  ),
  Destination(
    name: "Qəbələ meşəsi",
    type: Destination_Type.forest,
    image_url: 'https://picsum.photos/250?image=9',
    region: "Qəbələ",
  ),
];