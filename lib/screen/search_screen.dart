import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/helpers/app_colors.dart';
import 'package:travel_app/helpers/app_large_text.dart';

import '../model/destination.dart';
import '../providers/destinations.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // SearchScreen({Key? key}) : super(key: key);
  Future<QuerySnapshot>? destinationList;
  String region = '';

  // void initSearchDestination(String enteredText) {
  //   print(enteredText);
  //   destinationList = FirebaseFirestore.instance
  //       .collection('destination')
  //       .where("region", arrayContains: enteredText)
  //       .get();
  //   print(destinationList);
  //   setState(() {
  //     destinationList;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final providerData = Provider.of<Destinations>(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 40,
          ),
          AppLargeText(
            text: "Search for a Destination",
            size: 22,
          ),
          const SizedBox(
            height: 20.0,
          ),
          TextField(
            onChanged: (enteredText) {
              setState(() {
                region = enteredText;
              });
              // initSearchDestination(enteredText);
            },
            decoration: InputDecoration(
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide.none,
              ),
              hintText: "Search for a Destination",
              prefixIcon: const Icon(Icons.search),
              prefixIconColor: AppColors.buttonBackgroundColor,
            ),
          ),
          Expanded(
            child: StreamBuilder<List<Destination>>(
              stream: providerData.initSearchDestination(region),
              initialData: [],
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.connectionState == ConnectionState.active ||
                    snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return const Text('Error');
                  } else {
                    print("***************");
                    print(snapshot.data!.length);
                    return ListView.separated(
                      itemBuilder: (BuildContext ctx, int index) {
                        final titre = snapshot.data![index].name;
                        print("______________");
                        print(snapshot.data![index].name);
                        return ListTile(
                          title: Text(titre),
                        );
                      },
                      separatorBuilder: (context, index) => const Divider(
                        color: Colors.black,
                      ),
                      itemCount: snapshot.data!.length,
                    );
                  }
                } else {
                  return const Center(
                    child: Text("SOMETHING UNKNOWN"),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
