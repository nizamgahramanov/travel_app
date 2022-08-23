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
        width: 80,
        height: 80,
        margin: EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              info,
              style: const TextStyle(color: Colors.blueAccent, fontSize: 27),
            ),
          ],
        ),
      ),
    );
  }
}
