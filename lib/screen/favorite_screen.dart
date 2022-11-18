import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:travel_app/services/firebase_firestore_service.dart';

import '../helpers/app_colors.dart';
import '../helpers/app_large_text.dart';
import '../model/destination.dart';
import 'no_favorite_screen.dart';

class FavoriteScreen extends StatelessWidget {
  // final List<Destination> favoriteList;
  final _firebaseAuth = FirebaseAuth.instance.currentUser;
  FavoriteScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _firebaseAuth == null ? const NoFavoriteScreen():StreamBuilder<List<Destination>>(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.connectionState == ConnectionState.active ||
            snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return const Text('Error');
          } else {
            print(_firebaseAuth);
            return Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 0,
              ),
              child: MasonryGridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 12,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Stack(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(15),
                                ),
                                child: Image.network(
                                  snapshot.data![index].photoUrl[0],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 15,
                              bottom: 15,
                              right: 30,
                              child: Container(
                                height: 70,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: AppColors.inputColor.withOpacity(0.7),
                                ),
                                padding: const EdgeInsets.only(left: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: AppLargeText(
                                        text: snapshot.data![index].name,
                                        size: 21,
                                        color: AppColors.mainTextColor,
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: AppLargeText(
                                        text: snapshot.data![index].region,
                                        size: 10,
                                        color: AppColors.buttonBackgroundColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
            );
          }
        } else {
          return const Center(
            child: Text("SOMETHING UNKNOWN"),
          );
        }
      },
      stream: FireStoreService().getFavoriteList(),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   print(favoriteList.length);
  //   return Container(
  //     padding: EdgeInsets.zero,
  //     width: 70,
  //     height: MediaQuery.of(context).size.height * 0.37,
  //     color: AppColors.inputColor,
  //     child: ListView.builder(
  //       itemCount: favoriteList.length,
  //       padding: EdgeInsets.zero,
  //       itemBuilder: (context, index) => GestureDetector(
  //           // onTap: () => verticalListItemClicked(index),
  //           child: Container(
  //         margin: const EdgeInsets.all(1.5),
  //         width: 65,
  //         height: 65,
  //         clipBehavior: Clip.antiAlias,
  //         decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(20),
  //             border: Border.all(
  //               width: 1.2,
  //               color: AppColors.buttonBackgroundColor.withOpacity(0.4),
  //             )),
  //         child: ClipRRect(
  //           borderRadius: BorderRadius.circular(20),
  //           child: Image.network(
  //             // scale:3,
  //             favoriteList[index].photo_url[0],
  //             fit: BoxFit.cover,
  //           ),
  //         ),
  //       )),
  //     ),
  //   );
  // }
}
