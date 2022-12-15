import 'package:flutter/material.dart';

import '../helpers/app_light_text.dart';

class CustomNestedScrollView extends StatefulWidget {
  const CustomNestedScrollView({
    Key? key,
    required this.title,
    required this.child,
  }) : super(key: key);

  final String title;
  final Widget child;
  @override
  State<CustomNestedScrollView> createState() => _CustomNestedScrollViewState();
}

class _CustomNestedScrollViewState extends State<CustomNestedScrollView> {
  final ScrollController _scrollController = ScrollController();

  Key _key = const PageStorageKey({});
  bool _innerListIsScrolled = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_updateScrollPosition);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateScrollPosition);
    super.dispose();
  }

  void _updateScrollPosition() {
    if (!_innerListIsScrolled &&
        _scrollController.position.extentAfter == 0.0) {
      setState(() {
        _innerListIsScrolled = true;
      });
    } else if (_innerListIsScrolled &&
        _scrollController.position.extentAfter > 0.0) {
      print('_scrollController.position.extentAfter');
      print(_scrollController.position.extentAfter);

      setState(() {
        _innerListIsScrolled = false;
        _key = PageStorageKey({});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      controller: _scrollController,
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return <Widget>[
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver: SliverAppBar(
              leading: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),

              backgroundColor: Colors.white,
              pinned: true,
              stretch: true,
              expandedHeight: 120.0,
              flexibleSpace: FlexibleSpaceBar(
                expandedTitleScale: 2,
                collapseMode: CollapseMode.pin,
                centerTitle: false,

                title: _innerListIsScrolled
                    ? Text(
                        widget.title,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                        ),
                      )
                    : null,
                background: MyBackground(title: widget.title),
              ),
            ),
          ),
        ];
      },
      body: Builder(
        builder: (BuildContext context) {
          return CustomScrollView(
            slivers: [

              SliverOverlapInjector(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                  context,
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  height: MediaQuery.of(context).size.height *1.2,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 0,
                  ),
                  child: widget.child,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class MyBackground extends StatefulWidget {
  const MyBackground({
    Key? key,
    // required this.scrollController,
    required this.title,
  }) : super(key: key);
  final String title;
  @override
  State<MyBackground> createState() => _MyBackgroundState();
}

class _MyBackgroundState extends State<MyBackground> {
  @override
  Widget build(BuildContext context) {
    final FlexibleSpaceBarSettings? settings =
        context.dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>();
    if (settings != null) {
      print(settings.currentExtent);
      print(settings.maxExtent);
      print(kToolbarHeight);
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          AppLightText(
            text: widget.title,
            color: Colors.black,
            size: 24,
            padding: EdgeInsets.zero,
            spacing: 2,
            fontWeight: FontWeight.bold,
          )
        ],
      ),
    );
  }
}
