import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/model/user.dart' as app;
import 'package:travel_app/screen/wrapper.dart';
import 'package:travel_app/services/auth_service.dart';

class MainScreen extends StatefulWidget {
  bool? isLogin;

  MainScreen({Key? key, favoriteList}) : super(key: key);
  static const routeName = '/main';
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    print("MAIN SCREEN TRIGGERED");
    return StreamBuilder<app.User?>(
        stream: authService.user,
        builder: (
          _,
          AsyncSnapshot<app.User?> snapshot,
        ) {
          if (snapshot.connectionState == ConnectionState.active) {
            print("ACTIVE");
            print(snapshot.data);
            final app.User? user = snapshot.data;
            return user == null
                ? Wrapper(
                    isLogin: false,
                    bottomNavIndex: 0,
                  )
                : Wrapper(
                    isLogin: true,
                    bottomNavIndex: 0,
                  );
          } else {
            print("PROGRESS");
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
