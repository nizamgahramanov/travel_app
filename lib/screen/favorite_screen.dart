import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:travel_app/services/firebase_firestore_service.dart';
import '../model/destination.dart';
import '../widgets/staggered_grid_item.dart';
import 'detail_screen.dart';
import 'no_favorite_screen.dart';

class FavoriteScreen extends StatelessWidget {
  // final List<Destination> favoriteList;
  final _firebaseAuth = FirebaseAuth.instance.currentUser;
  FavoriteScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _firebaseAuth == null
        ? const NoFavoriteScreen()
        : SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 0,
              ),
              child: StreamBuilder<List<Destination>>(
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.connectionState ==
                          ConnectionState.active ||
                      snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return const Text('Error');
                    } else {
                        if(snapshot.hasData && snapshot.data!.isEmpty) {
                          return const NoFavoriteScreen();
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
                                        overview: snapshot.data![index]
                                            .overview,
                                        region: snapshot.data![index].region,
                                        type: snapshot.data![index].type,
                                        photoUrl: snapshot.data![index]
                                            .photoUrl,
                                        geoPoint: snapshot.data![index]
                                            .geoPoint),
                                  );
                                },
                                child: StaggeredGridItem(
                                  name: snapshot.data![index].name,
                                  region: snapshot.data![index].region,
                                  photo: snapshot.data![index].photoUrl[0],
                                ),
                              );
                            },
                          );
                        }
                    }
                  } else {
                    return const Center(
                      child: Text("SOMETHING UNKNOWN"),
                    );
                  }
                },
                stream: FireStoreService().getFavoriteList(),
              ),
            ),
          );
  }
}
