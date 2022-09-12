import 'package:flutter/material.dart';

import '../helpers/app_colors.dart';
import '../helpers/app_light_text.dart';

class AppSliverAppBar extends StatefulWidget {
  final String image_path;
  final String title_text;
  bool innerBoxIsScrolled;
  AppSliverAppBar({
    Key? key,
    required this.image_path,
    required this.title_text,
    required this.innerBoxIsScrolled
  }) : super(key: key);

  @override
  State<AppSliverAppBar> createState() => _AppSliverAppBarState();
}

class _AppSliverAppBarState extends State<AppSliverAppBar> {
  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: InkWell(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Icon(
          Icons.arrow_back,
          color: widget.innerBoxIsScrolled ? Colors.black : Colors.white,
        ),
      ),
      backgroundColor: Colors.white,
      pinned: true,
      //floating: true,
      stretch: true,
      expandedHeight: 200.0,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          widget.title_text,
          // "Great time to discover",
          style: TextStyle(
              color: widget.innerBoxIsScrolled ? Colors.black : Colors.white),
        ),
        background: Image.network(
          widget.image_path,
          // "https://i.picsum.photos/id/877/200/300.jpg?hmac=kxnqPHdYgfVGqD41ArUXpM0IuUCD2GYefTwBboMDVeA",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
