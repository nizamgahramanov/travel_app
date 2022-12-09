import 'package:algolia/algolia.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:travel_app/model/destination.dart';
import '../helpers/app_colors.dart';
import '../helpers/app_light_text.dart';
import '../model/debouncer.dart';
import '../widgets/staggered_grid_item.dart';
import 'detail_screen.dart';

class AlgoliaSearchScreen extends StatefulWidget {
  const AlgoliaSearchScreen({Key? key}) : super(key: key);

  @override
  State<AlgoliaSearchScreen> createState() => _AlgoliaSearchScreenState();
}

class _AlgoliaSearchScreenState extends State<AlgoliaSearchScreen> {
  TextEditingController _searchTextController = TextEditingController(text: "");
  List<AlgoliaObjectSnapshot>? _results;
  bool _searching = false;
  bool _isShowClearIcon = false;
  final _debouncer = Debouncer(milliseconds: 400);
  void _search() async {
    setState(() {
      _searching = true;
      _isShowClearIcon = true;
    });

    Algolia algolia = const Algolia.init(
      applicationId: 'MIXLQ70OML',
      apiKey: '110626843589be72cf0163bf9c36b01b',
    );

    AlgoliaQuery query = algolia.instance.index('destinations');
    query = query.query(_searchTextController.text);

    _results = (await query.getObjects()).hits;
    print("RESULT");
    print(_results);
    // print(Map<String, dynamic>.from(_results[0].data));
    // print(_results[0].data['photo_url']);
    setState(() {
      _searching = false;
    });
    if (_searchTextController.text.length < 2) {
      setState(() {
        _isShowClearIcon = false;
      });
    }
  }

  @override
  void dispose() {
    _searchTextController.dispose();

    super.dispose();
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
            Column(
              children: [
                AppLightText(
                  text: "Search",
                  size: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  spacing: 2,
                  padding: EdgeInsets.zero,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _searchTextController,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.name,
                  enableSuggestions: true,
                  autocorrect: true,
                  decoration: InputDecoration(
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.buttonBackgroundColor,
                        width: 2,
                      ),
                    ),
                    suffixIcon: _isShowClearIcon
                        ? IconButton(
                            onPressed: () {
                              _searchTextController.clear();
                              setState(() {
                                _isShowClearIcon = false;
                                if (_results != null) {
                                  _results=null;
                                }
                              });
                            },
                            icon: Icon(Icons.clear),
                          )
                        : null,
                    prefixIconColor: AppColors.buttonBackgroundColor,
                  ),
                  onChanged: (_) {
                    if (_searchTextController.text.length >= 2) {
                      _debouncer.run(() {
                        _search();
                      });
                    }
                  },
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).unfocus();
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: _searching == true
                  ? const Center(
                      child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(),
                    ))
                  : _results == null
                      ? Center(
                          child: SvgPicture.asset('assets/svg/search_screen.svg'),
                        )
                      : _results!.isEmpty
                          ? SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  height: 330,
                                  // color: Colors.blue,
                                  child: SvgPicture.asset(
                                      'assets/svg/no_result_found.svg'),
                                ),
                                AppLightText(
                                  text: 'No Result Found',
                                  padding: EdgeInsets.zero,
                                  spacing: 0,
                                  fontWeight: FontWeight.bold,
                                  textAlign: TextAlign.center,
                                  alignment: Alignment.center,
                                  color: Colors.black54,
                                  size: 18,

                                ),
                              ],
                            ),
                          )
                          : MasonryGridView.count(
                              crossAxisCount: 2,
                              itemCount: _results!.length,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              itemBuilder: (context, index) {
                                AlgoliaObjectSnapshot snap = _results![index];
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
                                        geoPoint: GeoPoint(
                                          snap.data['_geoloc']['lat'],
                                          snap.data['_geoloc']['lng'],
                                        ),
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
