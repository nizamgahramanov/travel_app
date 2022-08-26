import 'package:flutter/material.dart';
import 'package:travel_app/screen/detail_screen.dart';
import 'package:travel_app/screen/splash_screen.dart';

void main() async{
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
      home: SplashScreen(),
      routes: {
        DetailScreen.routeName: (context) => DetailScreen(),
      },
    );
  }
}
