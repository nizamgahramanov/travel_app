import 'package:flutter/material.dart';
import 'package:travel_app/helpers/app_colors.dart';
import 'package:travel_app/screen/detail_screen.dart';
import 'package:travel_app/screen/main_screen.dart';
import 'package:travel_app/screen/splash_screen.dart';

import 'model/destination.dart';
import 'model/dummy_data.dart';

void main() async{
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Destination> favorites = [];

  void toggleFavorite(int id) {
    print("TOGGLE FAVORITE");
    final existingIndex = favorites.indexWhere((element) => element.id == id);
    if (existingIndex >= 0) {
      setState(() {
        favorites.removeAt(existingIndex);
      });
    } else {
      setState(() {
        favorites.add(destinations.firstWhere((element) => element.id==id));
      });
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textSelectionTheme: TextSelectionThemeData(
          selectionColor: AppColors.buttonBackgroundColor,
          cursorColor: AppColors.buttonBackgroundColor,
          selectionHandleColor: AppColors.buttonBackgroundColor,
        ),
      ),
      home: SplashScreen(),
      routes: {
        DetailScreen.routeName: (context) => DetailScreen(toggleFavorite),
        MainScreen.routeName:(context) => MainScreen(favoriteList: favorites,),
      },
    );
  }
}
