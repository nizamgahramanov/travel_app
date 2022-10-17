import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/helpers/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../model/destination.dart';
import '../providers/destinations.dart';
import '../widgets/search_result_view.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // SearchScreen({Key? key}) : super(key: key);
  Future<QuerySnapshot>? destinationList;
  String? region;

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
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 40,
          ),
          Container(
            height: 70,
            // decoration: BoxDecoration(
            //   color: AppColors.textColor2,
            //   borderRadius: BorderRadius.circular(15.0),
            //   boxShadow: const [
            //     BoxShadow(
            //         color: Colors.grey, blurRadius: 2.0, spreadRadius: 0.4)
            //   ],
            // ),
            child: TextField(
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
          ),
          if (region != null)
            Expanded(
              child: SingleChildScrollView(
                child: StreamBuilder<List<Destination>>(
                  stream: providerData.initSearchDestination(region!),
                  initialData: const [],
                  builder: (ctx, snapshot) {
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
                        print("***************");
                        print(snapshot.data!.length);
                        return SearchResultView(snapshot.data!);
                      }
                    } else {
                      return const Center(
                        child: Text("SOMETHING UNKNOWN"),
                      );
                    }
                  },
                ),
              ),
            ),
          if (region == null)
            Expanded(
              child: SvgPicture.asset('assets/images/destination_search.svg'),
            ),
        ],
      ),
    );
  }
}
