import 'package:algolia/algolia.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/model/destination.dart';

import 'carousel_item.dart';

class SearchResultView extends StatefulWidget {
  final AlgoliaObjectSnapshot dataSnapshot;
  const SearchResultView(this.dataSnapshot, {Key? key}) : super(key: key);
  @override
  State<SearchResultView> createState() => _SearchResultViewState();
}

class _SearchResultViewState extends State<SearchResultView> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisExtent: 250,
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (_, index) {
        return CarouselItem(
          name: widget.dataSnapshot.data['name'],
          photos: widget.dataSnapshot.data['photo_url'][0],
          region: widget.dataSnapshot.data['region'],
        );
      },
      itemCount: widget.dataSnapshot.data.length,
    );
  }
}
