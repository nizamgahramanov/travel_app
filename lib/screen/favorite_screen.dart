import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:travel_app/services/firebase_firestore_service.dart';
import 'package:travel_app/widgets/network_connection_checker.dart';
import '../helpers/constants.dart';
import '../model/destination.dart';
import '../widgets/spinner.dart';
import '../widgets/staggered_grid_item.dart';
import 'detail_screen.dart';
import 'error_and_no_network_and_favorite_screen.dart';

class FavoriteScreen extends StatelessWidget {
  // final List<Destination> favoriteList;
  final _firebaseAuth = FirebaseAuth.instance.currentUser;
  FavoriteScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NetworkConnectionChecker(

      child: _firebaseAuth == null
          ? ErrorAndNoNetworkAndFavoriteScreen(
              text: 'no_favorites_yet_info'.tr(),
              path: noFavoriteScreenImage,
        //       width: 300,
        // height: 300,
            )
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 0,
                ),
                child: StreamBuilder<List<Destination>>(
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Spinner();
                    } else if (snapshot.connectionState ==
                            ConnectionState.active ||
                        snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        print("FAVORITE AHAS ERROR");
                        print(snapshot);
                        return ErrorAndNoNetworkAndFavoriteScreen(
                          text: "something_went_wrong_error_msg".tr(),
                          path: errorImage
                          // width: 300,
                          // height: 300,
                        );
                      } else {
                        if (snapshot.hasData && snapshot.data!.isEmpty) {
                          print("NO FAVORITE");
                          return ErrorAndNoNetworkAndFavoriteScreen(
                            text: 'no_favorites_yet_info'.tr(),
                            path: noFavoriteScreenImage,
                            // width: 300,
                            // height: 300,
                          );
                        } else {
                          return MasonryGridView.count(
                            crossAxisCount: 2,
                            itemCount: snapshot.data!.length,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                    DetailScreen.routeName,
                                    arguments: Destination(
                                      id: snapshot.data![index].id,
                                      name: snapshot.data![index].name,
                                      overview: snapshot.data![index].overview,
                                      overviewAz:
                                          snapshot.data![index].overviewAz,
                                      region: snapshot.data![index].region,
                                      regionAz: snapshot.data![index].regionAz,
                                      category: snapshot.data![index].category,
                                      photoUrl: snapshot.data![index].photoUrl,
                                      geoPoint: snapshot.data![index].geoPoint,
                                    ),
                                  );
                                },
                                child: StaggeredGridItem(
                                  name: snapshot.data![index].name,
                                  region: snapshot.data![index].region,
                                  regionAz: snapshot.data![index].regionAz,
                                  photo: snapshot.data![index].photoUrl[0],
                                ),
                              );
                            },
                          );
                        }
                      }
                    } else {
                      return ErrorAndNoNetworkAndFavoriteScreen(
                        text: 'no_favorites_yet_info'.tr(),
                        path: noFavoriteScreenImage,
                      );
                    }
                  },
                  stream: FireStoreService().getFavoriteList(),
                ),
              ),
            ),
    );
  }
}
