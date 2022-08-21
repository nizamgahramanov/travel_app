import 'package:flutter/material.dart';
import 'package:travel_app/model/destination.dart';
import '../model/dummy_data.dart';

class StackedCarousel extends StatelessWidget {
  final String name;
  final String image_url;
  StackedCarousel(this.name, this.image_url);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(
            left: 12,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          width: 250,
          height: 700,
          clipBehavior: Clip.antiAlias,
          child: Image.network(
            image_url,
            scale: 1.0,
            fit: BoxFit.fill,
          ),
        ),
        Positioned(
          left: 20,
          bottom: 10,
          child: Text(
            name,
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
