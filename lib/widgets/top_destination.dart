import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/app_colors.dart';
import '../helpers/app_large_text.dart';
import '../helpers/app_light_text.dart';
import '../model/destination.dart';
import '../providers/destinations.dart';
class TopDestination extends StatelessWidget {
  const TopDestination({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final providerData = Provider.of<Destinations>(context);

    return Column(
      children: [
        const SizedBox(
          height: 40,
        ),
        Container(
          alignment: Alignment.topLeft,
          margin: const EdgeInsets.symmetric(
            vertical: 0,
            horizontal: 20,
          ),
          child: AppLargeText(
            text: "Top Destinations",
            size: 22,
            color: AppColors.mainTextColor,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        StreamBuilder<List<Destination>>(
          stream: providerData.destinationItemsAll,
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
                return SizedBox(
                  height: 100,
                  width: double.infinity,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(left: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.inputColor,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              width: 120,
                              clipBehavior: Clip.antiAlias,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  snapshot.data![index].photoUrl[0],
                                  scale: 1.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  AppLightText(text: "Caspian Sea"),
                                  AppLightText(text: "Baku")
                                ],
                              ),
                            )
                          ],
                        ),
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
          }
        ),
      ],
    );
  }
}