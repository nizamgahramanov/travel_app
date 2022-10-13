import 'package:flutter/material.dart';

class AdvancedSearchScreen extends StatelessWidget {
  const AdvancedSearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPersistentHeader(delegate: CustomSliverAppBarDelegate(expandedHeight:200), pinned: true,),
        buildImages()
      ],
    );
  }
  Widget buildImages()=>SliverGrid(delegate: SliverChildBuilderDelegate((context, index) => ImageWidget(index:index),childCount: 20), gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2))
}

class CustomSliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  CustomSliverAppBarDelegate({ required this.expandedHeight});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    // TODO: implement build
    return Stack(fit: StackFit.expand, children: [buildAppBar(shrinkOffset)],);
  }

  Widget buildAppBar(double shrinkOffset) => AppBar(

  );
  @override
  // TODO: implement maxExtent
  double get maxExtent => expandedHeight;

  @override
  // TODO: implement minExtent
  double get minExtent => kToolbarHeight+30;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    throw UnimplementedError();
  }
  
}

