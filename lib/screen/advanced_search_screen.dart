import 'package:flutter/material.dart';

class AdvancedSearchScreen extends StatelessWidget {
  const AdvancedSearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          delegate: CustomSliverAppBarDelegate(expandedHeight: 200),
          pinned: true,
        ),
        buildImages()
      ],
    );
  }

  Widget buildImages() => SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) => ImageWidget(index: index),
          childCount: 20,
        ),
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      );
}

class ImageWidget extends StatelessWidget {
  final int index;
  ImageWidget({required this.index});
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.teal[100 * (index % 9)],
      child: Text('Grid Item $index'),
    );
  }
}

class CustomSliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  CustomSliverAppBarDelegate({required this.expandedHeight});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final size = 60;
    final top = expandedHeight - shrinkOffset-size;
    return Stack(
      fit: StackFit.expand,
      clipBehavior: Clip.antiAlias,
      children: [
        buildBackground(shrinkOffset),
        buildAppBar(shrinkOffset),
        Positioned(
          top: top,
          left: 20,
          right: 20,
          child: buildFloating(shrinkOffset),
        )
      ],
    );
  }

  double appear(double shrinkOffset) => shrinkOffset / expandedHeight;
  double disappear(double shrinkOffset) => 1 - shrinkOffset / expandedHeight-0.7;
  Widget buildAppBar(double shrinkOffset) => Opacity(
        opacity: appear(shrinkOffset),
        child: AppBar(
          title: Card(
            child: Row(
              children: [
                Expanded(child: buildButton(text: "Share", icon: Icons.share)),
                Expanded(child: buildButton(text: "Like", icon: Icons.thumb_up))
              ],
            ),
          ),
          centerTitle: true,
        //   title: TextField(
        //   textAlign : TextAlign.center,
        //   // The style of the input field
        //   decoration: InputDecoration(
        //     hintText: 'Title',
        //     icon: Icon(Icons.edit), // Edit icon
        //     // The style of the hint text
        //     hintStyle: TextStyle(
        //       color: Colors.black,
        //       fontSize: 18,
        //     ),
        //   ),
        //   // The controller of the input box
        // ),
          automaticallyImplyLeading: false,
        ),
      );

  Widget buildBackground(double shrinkOffset) => Opacity(
      opacity: disappear(shrinkOffset),
      child: Image.asset(
        "assets/images/search.jpg",
        fit: BoxFit.cover,
      ));

  Widget buildFloating(double shrinkOffset) => Opacity(
    opacity: disappear(shrinkOffset),
    child: Card(
          child: Row(
            children: [
              Expanded(child: buildButton(text: "Share", icon: Icons.share)),
              Expanded(child: buildButton(text: "Like", icon: Icons.thumb_up))
            ],
          ),
        ),
  );
  Widget buildButton({
    required String text,
    required IconData icon,
  }) =>
      TextButton(
          onPressed: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon),
              const SizedBox(
                width: 12,
              ),
              Text(
                text,
                style: TextStyle(fontSize: 20),
              )
            ],
          ));
  @override
  // TODO: implement maxExtent
  double get maxExtent => expandedHeight;

  @override
  // TODO: implement minExtent
  double get minExtent => kToolbarHeight + 40;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    throw UnimplementedError();
  }
}
