import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/helpers/app_colors.dart';

import '../helpers/app_large_text.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  static const routeName = '/profile';
  final List title_list = const [
    "Name",
    "Email Address",
    "Change Password",
  ];
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Column(
          children: [
            Container(
              color: Colors.yellow,
              width: double.maxFinite,
              height: MediaQuery.of(context).size.height * 0.38,
              child: Stack(
                children: [
                  Positioned(
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: MediaQuery.of(context).size.width,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(35),
                        bottomRight: Radius.circular(35),
                      ),
                      child: Image.asset(
                        "assets/images/profile_screen.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 50,
                    left: 20,
                    right: 20,
                    child: AppLargeText(
                      text: 'YOUR SETTINGS IN TRAVEL APP',
                      color: Colors.white,
                      size: 32,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  final data = widget.title_list[index];
                  return ListTile(
                    trailing: const Icon(Icons.edit_outlined),
                    title: Text(
                      data,
                    ),
                    subtitle: Text("Nizam Gahramanov"),
                  );
                },
                separatorBuilder: (_, __) => const Divider(),
                itemCount: widget.title_list.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
