import 'package:algolia/algolia.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../helpers/app_colors.dart';
import '../widgets/carousel_item.dart';

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
    print(_results);
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
                          child: SvgPicture.asset(
                              'assets/images/destination_search.svg'),
                        )
                      : GridView.builder(
                          itemCount: _results.length,
                          itemBuilder: (BuildContext ctx, int index) {
                            print("ENTERED");
                            AlgoliaObjectSnapshot snap = _results[index];
                            return CarouselItem(
                              name: snap.data['name'],
                              photos: snap.data['photo_url'][0],
                              region: snap.data['region'],
                            );
                            // return ListTile(
                            //   leading: CircleAvatar(
                            //     child: Text(
                            //       (index + 1).toString(),
                            //     ),
                            //   ),
                            //   title: Text(snap.data["name"]),
                            //   subtitle: Text(snap.data["region"]),
                            // );
                          },
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 12,
                                  crossAxisSpacing: 12),
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
