import 'package:flutter/material.dart';
import 'package:travel_app/helpers/app_colors.dart';
import 'package:travel_app/providers/destinations.dart';
import 'package:travel_app/reusable/custom_page_route.dart';
import 'package:travel_app/screen/add_destination_screen.dart';
import 'package:travel_app/screen/change_email_screen.dart';
import 'package:travel_app/screen/change_name.dart';
import 'package:travel_app/screen/change_password_screen.dart';
import 'package:travel_app/screen/detail_screen.dart';
import 'package:travel_app/screen/main_screen.dart';
import 'package:travel_app/screen/password_screen.dart';
import 'package:travel_app/screen/profile_screen.dart';
import 'package:travel_app/screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:travel_app/screen/user_info.dart';
import 'package:provider/provider.dart';
import 'db_manager/firebase_firestore_service.dart';
import 'model/destination.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Destination> favorites = [];

  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case DetailScreen.routeName:
        return CustomPageRoute(
          child: DetailScreen(toggleFavorite),
          settings: settings,
        );
      case MainScreen.routeName:
        return CustomPageRoute(
            child: MainScreen(
          favoriteList: favorites,
        ));
      case PasswordScreen.routeName:
        print("PASSWORD GO ");
        print(settings);
        return CustomPageRoute(
          child: const PasswordScreen(),
          settings: settings,
        );
      case UserInfo.routeName:
        return CustomPageRoute(
          child: UserInfo(),
          settings: settings,
        );
      case ProfileScreen.routeName:
        return CustomPageRoute(
          child: const ProfileScreen(),
          settings: settings,
        );
      case ChangePasswordScreen.routeName:
        return CustomPageRoute(
          child: const ChangePasswordScreen(),
          settings: settings,
        );
      case ChangeEmailScreen.routeName:
        return CustomPageRoute(
          child: const ChangeEmailScreen(),
          settings: settings,
        );
      case ChangeNameScreen.routeName:
        return CustomPageRoute(
          child: const ChangeNameScreen(),
          settings: settings,
        );
      case AddDestinationScreen.routeName:
        return CustomPageRoute(
          child: const AddDestinationScreen(),
          settings: settings,
        );
    }
  }

  void toggleFavorite(int id) {
    print("TOGGLE FAVORITE");
    final existingIndex = favorites.indexWhere((element) => element.id == id);
    if (existingIndex >= 0) {
      setState(() {
        favorites.removeAt(existingIndex);
      });
    } else {
      setState(() {
        // favorites.add(destinations.firstWhere((element) => element.id == id));
      });
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Destinations(),
        ),
      ],
      child: MaterialApp(
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
        home: const SplashScreen(),
        onGenerateRoute: (route) => onGenerateRoute(route),
        // routes: {
        //   DetailScreen.routeName: (context) => DetailScreen(toggleFavorite),
        //   MainScreen.routeName:(context) => MainScreen(favoriteList: favorites,),
        //   PasswordScreen.routeName:(context) =>PasswordScreen(),
        //   UserInfo.routeName:(context) =>UserInfo(),
        // },
      ),
    );
  }
}
