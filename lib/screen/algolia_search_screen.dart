import 'package:algolia/algolia.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/model/destination.dart';
import 'package:travel_app/reusable/custom_text_form_field.dart';
import 'package:travel_app/widgets/network_connection_checker.dart';

import '../helpers/app_colors.dart';
import '../helpers/app_light_text.dart';
import '../helpers/constants.dart';
import '../model/debouncer.dart';
import '../services/network_service.dart';
import '../widgets/spinner.dart';
import '../widgets/staggered_grid_item.dart';
import 'detail_screen.dart';

class AlgoliaSearchScreen extends StatefulWidget {
  const AlgoliaSearchScreen({Key? key}) : super(key: key);

  @override
  State<AlgoliaSearchScreen> createState() => _AlgoliaSearchScreenState();
}

class _AlgoliaSearchScreenState extends State<AlgoliaSearchScreen> {
  final TextEditingController _searchTextController =
      TextEditingController(text: "");
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
      applicationId: algoliaAppId,
      apiKey: algoliaApiKey,
    );

    AlgoliaQuery query = algolia.instance.index('destinations');
    query = query.query(_searchTextController.text);
    _results = (await query.getObjects()).hits;
    setState(() {
      _searching = false;
    });

    if (_searchTextController.text.length < 2) {
      print('Length');
      print(_searchTextController.text.length);
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
    var networkStatus = Provider.of<NetworkStatus>(context);

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
                  text: 'search_title'.tr(),
                  size: 18,
                  color: AppColors.blackColor,
                  fontWeight: FontWeight.bold,
                  spacing: 2,
                  padding: EdgeInsets.zero,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  controller: _searchTextController,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.done,
                  suffixIcon: _isShowClearIcon
                      ? IconButton(
                          onPressed: () {
                            _searchTextController.clear();
                            FocusScope.of(context).unfocus();
                            setState(() {
                              _isShowClearIcon = false;
                              if (_results != null) {
                                _results = null;
                              }
                            });
                          },
                          icon: const Icon(Icons.clear),
                        )
                      : null,
                  onChanged: (_) {
                    if (_searchTextController.text.length >= 2 &&
                        networkStatus == NetworkStatus.online) {
                      _debouncer.run(() {
                        _search();
                      });
                    } else {
                      setState(() {
                        if (_results != null) {
                          _results = null;
                        }
                        _isShowClearIcon = false;
                      });
                    }
                  },
                  onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
                )
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            NetworkConnectionChecker(
              child: Expanded(
                child: _searching == true
                    ? const Spinner()
                    : _results == null
                        ? Center(
                            child: SvgPicture.asset(searchScreenImage),
                          )
                        : _results!.isEmpty
                            ? SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      height: 350,
                                      // color: Colors.blue,
                                      child:
                                          SvgPicture.asset(noResultFoundImage),
                                    ),
                                    AppLightText(
                                      text: 'no_result_found_info'.tr(),
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
                                          overviewAz: snap.data['overview_az'],
                                          region: snap.data['region'],
                                          regionAz: snap.data['region_az'],
                                          category: snap.data['category'],
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
                                      regionAz: snap.data['region_az'],
                                      photo: snap.data['photo_url'][0],
                                    ),
                                  );
                                },
                              ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
