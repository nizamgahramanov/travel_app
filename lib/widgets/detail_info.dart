import 'package:flutter/material.dart';

class DetailInfo extends StatelessWidget {
  final String title;
  final String info;
  DetailInfo({required this.title, required this.info});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 10.0,
      color: Colors.grey,
      child: Container(
        width: 110,
        height: 110,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 20),
            ),
            Text(
              info,
              style: TextStyle(color: Colors.blueAccent, fontSize: 27),
            ),
          ],
        ),
      ),
    );
  }
}
