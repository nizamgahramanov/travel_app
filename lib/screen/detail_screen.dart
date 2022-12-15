import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/helpers/app_colors.dart';
import 'package:travel_app/helpers/custom_icon_text.dart';
import 'package:travel_app/helpers/utility.dart';
import 'package:travel_app/screen/maps_screen.dart';
import 'package:travel_app/screen/wrapper.dart';
import 'package:travel_app/services/firebase_firestore_service.dart';
import '../helpers/app_light_text.dart';
import '../helpers/custom_button.dart';
import '../model/destination.dart';

class DetailScreen extends StatefulWidget {
  static const routeName = '/detail';
  DetailScreen({Key? key}) : super(key: key);
  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>
    with TickerProviderStateMixin {
  ScrollController _scrollController = ScrollController();
  bool isSelecting = false;
  var user = FirebaseAuth.instance.currentUser;
  bool _innerListIsScrolled = false;
  Key _key = const PageStorageKey({});
  void toggleFavorite(Destination destination) {
    if (user != null) {
      // store destination in firestore database
      FireStoreService().toggleFavorites(user!.uid, destination);
    } else {
      // should be open dialog in order to make kindly force user to login
      Utility.getInstance().showAlertDialog(
        context: context,
        alertTitle: 'be_our_valuable_member_dialog_msg_title'.tr(),
        popButtonText: 'back_btn'.tr(),
        onPopTap: () => Navigator.of(context).pop(),
        popButtonColor: AppColors.backgroundColorOfApp,
        popButtonTextColor: Colors.black,
        isShowActionButton: true,
        alertMessage: 'please_sign_up_before_make_favorite_dialog_msg_subtitle'.tr(),
        actionButtonText: 'sign_up_btn'.tr(),
        actionButtonColor: AppColors.buttonBackgroundColor,
        onTapAction: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Wrapper(
              isLogin: false,
              bottomNavIndex: 1,
            ),
          ),
        ),
      );
    }
  }

  void _updateScrollPosition() {
    if (!_innerListIsScrolled &&
        _scrollController.position.extentAfter == 0.0) {
      setState(() {
        _innerListIsScrolled = true;
      });
    } else if (_innerListIsScrolled &&
        _scrollController.position.extentAfter > 0.0) {
      setState(() {
        _innerListIsScrolled = false;
        // Reset scroll positions of the TabBarView pages
        _key = const PageStorageKey({});
      });
    }
  }

  @override
  void initState() {
    _scrollController.addListener(_updateScrollPosition);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateScrollPosition);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final clickedDestination =
        ModalRoute.of(context)!.settings.arguments as Destination;
    Map<String, dynamic> mapArgument = {
      "isSelecting": isSelecting,
      "geoPoint": clickedDestination.geoPoint,
      "zoom": 12.0,
      "name": clickedDestination.name
    };
    void showDestinationOnMap() {
      Navigator.of(context)
          .pushNamed(MapScreen.routeName, arguments: mapArgument);
    }

    final FlexibleSpaceBarSettings? settings =
        context.dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>();
    print(settings);
    return Scaffold(
      backgroundColor: AppColors.backgroundColorOfApp,
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          print("_innerListIsScrolled");
          print(_innerListIsScrolled);
          return <Widget>[
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                // titleSpacing: 20,
                centerTitle: true,
                leadingWidth: 75,
                backgroundColor: _innerListIsScrolled
                    ? AppColors.buttonBackgroundColor
                    : AppColors.backgroundColorOfApp,
                automaticallyImplyLeading: true,
                leading: Container(
                  margin: const EdgeInsets.only(
                      left: 15, right: 5, top: 5, bottom: 5),
                  // width: 60,
                  // color: Colors.redAccent,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: EdgeInsets.zero,
                      primary: AppColors.buttonBackgroundColor,
                    ),
                    child: Icon(
                      Icons.arrow_back_rounded,
                      color: AppColors.backgroundColorOfApp,
                    ),
                  ),
                ),
                titleTextStyle: const TextStyle(color: Colors.redAccent),
                actions: [
                  StreamBuilder<QuerySnapshot>(
                      stream: user == null
                          ? null
                          : FireStoreService()
                              .isDestinationFavorite(clickedDestination.id!),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.none ||
                            snapshot.connectionState ==
                                ConnectionState.active) {
                          return Container(
                            // color: Colors.redAccent,
                            width: 50,
                            margin: const EdgeInsets.only(
                                right: 15, left: 5, top: 5, bottom: 5),
                            child: TextButton(
                              onPressed: () =>
                                  toggleFavorite(clickedDestination),
                              style: ElevatedButton.styleFrom(
                                shape: const CircleBorder(),
                                padding: EdgeInsets.zero,
                                primary: AppColors.buttonBackgroundColor,
                              ),
                              child: !snapshot.hasData ||
                                      snapshot.data!.docs.isEmpty
                                  ? Icon(
                                      Icons.favorite_border_outlined,
                                      color: AppColors.backgroundColorOfApp,
                                    )
                                  : Icon(
                                      Icons.favorite,
                                      color: AppColors.backgroundColorOfApp,
                                    ),
                            ),
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }),
                ],
                expandedHeight: MediaQuery.of(context).size.height * .6,
                floating: true,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  // titlePadding: EdgeInsets.zero,
                  expandedTitleScale: 1.7,
                  collapseMode: CollapseMode.parallax,
                  titlePadding: _innerListIsScrolled
                      ? const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 70,
                        )
                      : const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 20,
                        ),
                  centerTitle: false,
                  title: Container(
                    // color: Colors.redAccent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        AppLightText(
                          text: clickedDestination.name,
                          size: 16,
                          color: AppColors.backgroundColorOfApp,
                          fontWeight: FontWeight.bold,
                          spacing: 2,
                          padding: EdgeInsets.zero,
                        ),
                        CustomIconText(
                          text: clickedDestination.region,
                          size: 12,
                          color: AppColors.backgroundColorOfApp,
                          icon: Icon(
                            Icons.location_on_outlined,
                            size: 12,
                            color: AppColors.backgroundColorOfApp,
                          ),
                          spacing: 3,
                          isIconFirst: true,
                        )
                      ],
                    ),
                  ),
                  background: Builder(
                    builder: (BuildContext context) {
                      return MyBackground(
                        clickedDestination: clickedDestination,
                      );
                    },
                  ),
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
                    width: double.maxFinite,
                    height: MediaQuery.of(context).size.height * .4,
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          // color: Colors.amberAccent,
                          padding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 15,
                              ),
                              AppLightText(
                                text: 'overview'.tr(),
                                color: Colors.black,
                                size: 22,
                                fontWeight: FontWeight.bold,
                                spacing: 2,
                                padding: EdgeInsets.zero,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              AppLightText(
                                spacing: 16,
                                text: clickedDestination.overview,
                                padding: EdgeInsets.zero,
                                textAlign: TextAlign.justify,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton:CustomButton(
        buttonText: 'view_on_map_btn'.tr(),
        borderRadius: 15,
        horizontalMargin: 20,
        verticalMargin: 20,
        onTap: () => showDestinationOnMap,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class MyBackground extends StatefulWidget {
  final Destination clickedDestination;

  MyBackground({required this.clickedDestination});

  @override
  State<MyBackground> createState() => _MyBackgroundState();
}

class _MyBackgroundState extends State<MyBackground> {
  int showImageIndex = 0;

  void verticalListItemClicked(int index) {
    setState(() {
      showImageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final FlexibleSpaceBarSettings? settings =
        context.dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>();
    if (settings != null) {
      print(settings.currentExtent);
      print(settings.maxExtent);
      print(kToolbarHeight);
    }
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned(
          height: settings!.maxExtent,
          width: MediaQuery.of(context).size.width,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.network(
              widget.clickedDestination.photoUrl[showImageIndex],
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          right: 20,
          bottom: 0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: LimitedBox(
              maxHeight: MediaQuery.of(context).size.height * 0.3,
              maxWidth: 60,
              child: Container(
                color: Colors.white,
                child: ListView.builder(
                  itemCount: widget.clickedDestination.photoUrl.length,
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () => verticalListItemClicked(index),
                    child: showImageIndex == index
                        ? Container(
                            margin: const EdgeInsets.all(4.0),
                            width: 50,
                            height: 50,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                width: 3,
                                color: Colors.black,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                widget.clickedDestination
                                    .photoUrl[showImageIndex],
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : Container(
                            margin: const EdgeInsets.all(4),
                            width: 50,
                            height: 50,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(
                                widget.clickedDestination.photoUrl[index],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}