import 'package:flutter/material.dart';
import 'package:travel_app/screen/detail_screen.dart';
import 'package:travel_app/screen/home_screen.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
      routes: {
        DetailScreen.routeName: (context) => DetailScreen(),
      },
    );
  }
}
