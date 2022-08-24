import 'package:flutter/material.dart';
import 'package:travel_app/model/destination.dart';
import '../model/dummy_data.dart';

class StackedCarousel extends StatelessWidget {
  final String name;
  final String image_url;
  final String region;
  StackedCarousel(this.name, this.image_url, this.region);
  @override
  Widget build(BuildContext context) {
    print("++++++++++++++++++++++++++++++++++++++++");
    // print(selected_type);
    print("----------------------------------------");
    // print(element_type);
    // print("****************************************");
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
          left: 25,
          bottom: 20,
          right: 15,
          child: Container(
            width: 230,
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white.withOpacity(0.6),
            ),
            padding: EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    name,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    region,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black45,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
