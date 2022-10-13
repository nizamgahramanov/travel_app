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
    // TODO: implement build
    return  CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          pinned: true,
          expandedHeight: 150.0,
          leadingWidth: 8,
          centerTitle: false,
          automaticallyImplyLeading: false,
          flexibleSpace: FlexibleSpaceBar(
            title: Container(
              margin: EdgeInsets.symmetric(horizontal: 0),
              height: 40,
              decoration: BoxDecoration(
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.6),
                      offset: const Offset(1.1, 1.1),
                      blurRadius: 5.0),
                ],
              ),
              child: CupertinoTextField(
                // controller: _filter,
                keyboardType: TextInputType.text,
                placeholder: 'Search',
                placeholderStyle: TextStyle(
                  color: Color(0xffC4C6CC),
                  fontSize: 14.0,
                  fontFamily: 'Brutal',
                ),
                prefix: Padding(
                  padding: const EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 5.0),
                  child: Icon(
                    Icons.search,
                    size: 18,
                    color: Colors.black,
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.white,
                ),
              ),
            ),

          ),
        ),
        SliverGrid(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200.0,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            childAspectRatio: 4.0,
          ),
          delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
              return Container(
                alignment: Alignment.center,
                color: Colors.teal[100 * (index % 9)],
                child: Text('Grid Item $index'),
              );
            },
            childCount: 20,
          ),
        ),
        SliverFixedExtentList(
          itemExtent: 50.0,
          delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
              return Container(
                alignment: Alignment.center,
                color: Colors.lightBlue[100 * (index % 9)],
                child: Text('List Item $index'),
              );
            },
          ),
        ),
      ],
    );
  }

  // SliverAppBar createSilverAppBar1() {
  //   return SliverAppBar(
  //     backgroundColor: Colors.redAccent,
  //     expandedHeight: 200,
  //     floating: false,
  //     elevation: 0,
  //     flexibleSpace: LayoutBuilder(
  //         builder: (BuildContext context, BoxConstraints constraints) {
  //           return FlexibleSpaceBar(
  //             collapseMode: CollapseMode.parallax,
  //             background: Container(
  //               color: Colors.white,
  //               child: Image.asset(
  //                 'assets/images/profile_screen.jpg',
  //                 fit: BoxFit.cover,
  //               ),
  //             ),
  //           );
  //         }),
  //   );
  // }

  SliverAppBar createSilverAppBar2() {
    return SliverAppBar(
      backgroundColor: Colors.redAccent,
      pinned: true,
      expandedHeight: 300,
      title: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        height: 40,
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.withOpacity(0.6),
                offset: const Offset(1.1, 1.1),
                blurRadius: 5.0),
          ],
        ),
        child: CupertinoTextField(
          // controller: _filter,
          keyboardType: TextInputType.text,
          placeholder: 'Search',
          placeholderStyle: TextStyle(
            color: Color(0xffC4C6CC),
            fontSize: 14.0,
            fontFamily: 'Brutal',
          ),
          prefix: Padding(
            padding: const EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 5.0),
            child: Icon(
              Icons.search,
              size: 18,
              color: Colors.black,
            ),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.white,
          ),
        ),
      ),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   final providerData = Provider.of<Destinations>(context);
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(
  //       horizontal: 15,
  //       vertical: 0,
  //     ),
  //     child: SingleChildScrollView(
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           const SizedBox(
  //             height: 40,
  //           ),
  //           TextField(
  //             onChanged: (enteredText) {
  //               setState(() {
  //                 region = enteredText;
  //               });
  //               // initSearchDestination(enteredText);
  //             },
  //             decoration: InputDecoration(
  //               filled: true,
  //               border: OutlineInputBorder(
  //                 borderRadius: BorderRadius.circular(8.0),
  //                 borderSide: BorderSide.none,
  //               ),
  //               hintText: "Search for a Destination",
  //               prefixIcon: const Icon(Icons.search),
  //               prefixIconColor: AppColors.buttonBackgroundColor,
  //             ),
  //           ),
  //           if (region != null)
  //             StreamBuilder<List<Destination>>(
  //               stream: providerData.initSearchDestination(region!),
  //               initialData: const [],
  //               builder: (ctx, snapshot) {
  //                 if (snapshot.connectionState == ConnectionState.waiting) {
  //                   return const Center(
  //                     child: CircularProgressIndicator(),
  //                   );
  //                 } else if (snapshot.connectionState ==
  //                         ConnectionState.active ||
  //                     snapshot.connectionState == ConnectionState.done) {
  //                   if (snapshot.hasError) {
  //                     return const Text('Error');
  //                   } else {
  //                     print("***************");
  //                     print(snapshot.data!.length);
  //                     return SearchResultView(snapshot.data!);
  //                   }
  //                 } else {
  //                   return const Center(
  //                     child: Text("SOMETHING UNKNOWN"),
  //                   );
  //                 }
  //               },
  //             ),
  //           if (region == null)
  //             SvgPicture.asset('assets/images/destination_search.svg'),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
