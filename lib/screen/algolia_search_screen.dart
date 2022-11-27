import 'package:algolia/algolia.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:travel_app/model/destination.dart';
import '../helpers/app_colors.dart';
import '../widgets/carousel_item.dart';
import '../widgets/staggered_grid_item.dart';
import 'detail_screen.dart';

class AlgoliaSearchScreen extends StatefulWidget {
  const AlgoliaSearchScreen({Key? key}) : super(key: key);

  @override
  State<AlgoliaSearchScreen> createState() => _AlgoliaSearchScreenState();
}

class _AlgoliaSearchScreenState extends State<AlgoliaSearchScreen> {
  TextEditingController _searchText = TextEditingController(text: "");
  List<AlgoliaObjectSnapshot> _results = [];
  bool _searching = false;

  void _search() async {
    setState(() {
      _searching = true;
    });
    Algolia algolia = const Algolia.init(
      applicationId: 'MIXLQ70OML',
      apiKey: '110626843589be72cf0163bf9c36b01b',
    );

    AlgoliaQuery query = algolia.instance.index('destinations');
    query = query.query(_searchText.text);

    _results = (await query.getObjects()).hits;
    print("RESULT");
    print(_results[0].data['photo_url']);
    setState(() {
      _searching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _searchText,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                ElevatedButton(
                  child: Text(
                    "Search",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: _search,
                ),
              ],
            ),
            Expanded(
              child: _searching == true
                  ? const Center(
                      child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(),
                    ))
                  : _results.isEmpty
                      ? Center(
                          child:
                              SvgPicture.asset('assets/svg/search_screen.svg'),
                        )
                      // : GridView.builder(
                      //     itemCount: _results.length,
                      //     itemBuilder: (BuildContext ctx, int index) {
                      //       print("ENTERED");
                      //       AlgoliaObjectSnapshot snap = _results[index];
                      //       return CarouselItem(
                      //         name: snap.data['name'],
                      //         photos: snap.data['photo_url'][0],
                      //         region: snap.data['region'],
                      //       );
                      //       // return ListTile(
                      //       //   leading: CircleAvatar(
                      //       //     child: Text(
                      //       //       (index + 1).toString(),
                      //       //     ),
                      //       //   ),
                      //       //   title: Text(snap.data["name"]),
                      //       //   subtitle: Text(snap.data["region"]),
                      //       // );
                      //     },
                      //     gridDelegate:
                      //         const SliverGridDelegateWithFixedCrossAxisCount(
                      //             crossAxisCount: 2,
                      //             mainAxisSpacing: 12,
                      //             crossAxisSpacing: 12),
                      //   ),
                      : MasonryGridView.count(
                          crossAxisCount: 2,
                          itemCount: _results.length,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          itemBuilder: (context, index) {
                            AlgoliaObjectSnapshot snap = _results[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  DetailScreen.routeName,
                                  arguments: Destination(
                                    id: snap.data['id'],
                                    name: snap.data['name'],
                                    overview: snap.data['overview'],
                                    region: snap.data['region'],
                                    type: snap.data['type'],
                                    photoUrl: snap.data['photo_url'],
                                    geoPoint: snap.data['_geoloc'],
                                  ),
                                );
                              },
                              child: StaggeredGridItem(
                                name: snap.data['name'],
                                region: snap.data['region'],
                                photo: snap.data['photo_url'][0],
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
