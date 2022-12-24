import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:travel_app/helpers/app_colors.dart';
import 'package:travel_app/helpers/constants.dart';
import 'package:travel_app/helpers/custom_icon_text.dart';
import 'package:travel_app/helpers/utility.dart';
import 'package:travel_app/screen/main_screen.dart';
import 'package:travel_app/screen/maps_screen.dart';
import 'package:travel_app/services/firebase_firestore_service.dart';
import 'package:travel_app/widgets/shimmer_effect.dart';

import '../helpers/app_light_text.dart';
import '../helpers/custom_button.dart';
import '../model/destination.dart';
import 'error_and_no_network_and_favorite_screen.dart';

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
        alertMessage:
            'please_sign_up_before_make_favorite_dialog_msg_subtitle'.tr(),
        actionButtonText: 'sign_up_btn'.tr(),
        actionButtonColor: AppColors.buttonBackgroundColor,
        onTapAction: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MainScreen(
              bottomNavIndex: 3,
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
    var locale = context.locale.languageCode;

    final clickedDestination =
        ModalRoute.of(context)!.settings.arguments as Destination;
    Map<String, dynamic> mapArgument = {
      "isSelecting": isSelecting,
      "geoPoint": clickedDestination.geoPoint,
      "zoom": 7.0,
      "name": clickedDestination.name
    };
    void showDestinationOnMap() {
      print("VIEW ON MAP");
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
                titleTextStyle: const TextStyle(color: AppColors.redAccent300,),
                actions: [
                  StreamBuilder<QuerySnapshot>(
                      stream: user == null
                          ? null
                          : FireStoreService()
                              .isDestinationFavorite(clickedDestination.id!),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: ShimmerEffect.circular(
                              width: 45,
                              height: 45,
                              shapeBorder: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              isCircle: true,
                            ),
                          );
                        } else if (snapshot.connectionState ==
                                ConnectionState.none ||
                            snapshot.connectionState ==
                                ConnectionState.active) {
                          if (snapshot.hasError) {
                            return ErrorAndNoNetworkAndFavoriteScreen(
                              text: 'something_went_wrong_error_msg'.tr(),
                              path: errorImage,
                            );
                          } else {
                            return Container(
                              // color: Colors.redAccent,
                              width: 50,
                              margin: const EdgeInsets.only(
                                right: 15,
                                left: 5,
                                top: 5,
                                bottom: 5,
                              ),
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
                          }
                        } else {
                          return ErrorAndNoNetworkAndFavoriteScreen(
                            text: 'something_went_wrong_error_msg'.tr(),
                            path: errorImage,
                          );
                        }
                      }),
                ],
                expandedHeight: MediaQuery.of(context).size.height * .6,
                floating: true,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  // titlePadding: EdgeInsets.zero,
                  expandedTitleScale: 1.8,
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
                          text: locale == 'az'
                              ? clickedDestination.regionAz
                              : clickedDestination.region,
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
                                color: AppColors.blackColor,
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
                                text: locale == 'az'
                                    ? clickedDestination.overviewAz
                                    : clickedDestination.overview,
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
      floatingActionButton: clickedDestination.geoPoint != null
          ? CustomButton(
              buttonText: 'view_on_map_btn'.tr(),
              borderRadius: 15,
              horizontalMargin: 20,
              verticalMargin: 20,
              onTap: () => showDestinationOnMap(),
              borderColor: AppColors.buttonBackgroundColor,
            )
          : null,
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
            child: CachedNetworkImage(
              height: settings.maxExtent,
              imageUrl: widget.clickedDestination.photoUrl[showImageIndex],
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              placeholder: (context, url) => Center(
                child: ShimmerEffect.rectangular(
                  height: settings.maxExtent,
                  isCircle: false,
                ),
              ),
              errorWidget: (context, url, error) {
                return _buildError(150, 150);
              },
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
              maxWidth: 70,
              child: Container(
                width: 60,
                color: AppColors.whiteColor,
                child: ListView.builder(
                  itemCount: widget.clickedDestination.photoUrl.length,
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () => verticalListItemClicked(index),
                    child: showImageIndex == index
                        ? _buildSmallList(
                            showImageIndex,
                            settings.maxExtent,
                            BoxDecoration(
                              borderRadius: BorderRadius.circular(13),
                              border: Border.all(
                                width: .5,
                                color: AppColors.buttonBackgroundColor,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.buttonBackgroundColor,
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                )
                              ],
                            ),
                          )
                        : _buildSmallList(
                            index,
                            settings.maxExtent,
                            BoxDecoration(
                              borderRadius: BorderRadius.circular(13),
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

  Widget _buildSmallList(int index, double height, BoxDecoration decoration) {
    return Container(
      height: 50,
      margin: const EdgeInsets.all(4),
      clipBehavior: Clip.antiAlias,
      decoration: decoration,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: CachedNetworkImage(
          height: height,
          imageUrl: widget.clickedDestination.photoUrl[index],
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          placeholder: (context, url) => const Center(
            child: ShimmerEffect.rectangular(
              height: 50,
              width: 50,
              isCircle: false,
            ),
          ),
          errorWidget: (context, url, error) {
            return _buildError(50, 50);
          },
        ),
      ),
    );
  }

  Widget _buildError(double? width, double? height) {
    return Center(
      child: SvgPicture.asset(
        placeholderImage,
        width: width,
        height: height,
      ),
    );
  }
}
