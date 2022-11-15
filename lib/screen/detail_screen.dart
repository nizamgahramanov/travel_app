import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/helpers/app_button.dart';
import 'package:travel_app/helpers/app_colors.dart';
import 'package:travel_app/helpers/custom_button.dart';
import 'package:travel_app/helpers/utility.dart';
import 'package:travel_app/model/user.dart';
import 'package:travel_app/screen/main_screen.dart';
import 'package:travel_app/screen/maps_screen.dart';
import 'package:travel_app/screen/wrapper.dart';
import 'package:travel_app/services/auth_service.dart';
import 'package:travel_app/services/firebase_firestore_service.dart';
import 'package:travel_app/widgets/detail_info.dart';
import '../helpers/app_large_text.dart';
import '../helpers/app_light_text.dart';
import '../model/circle_tab_indicator.dart';
import '../model/destination.dart';
import 'package:provider/provider.dart';
import '../providers/destinations.dart';

class DetailScreen extends StatefulWidget {
  static const routeName = '/detail';
  DetailScreen({Key? key}) : super(key: key);
  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>
    with TickerProviderStateMixin {
  int showImageIndex = 0;
  bool isSelecting = false;
  var user = FirebaseAuth.instance.currentUser;
  void verticalListItemClicked(int index) {
    setState(() {
      showImageIndex = index;
    });
  }

  void toggleFavorite(Destination destination) {
    if (user != null) {
      // store destination in firestore database
      FireStoreService().saveFavorites(user!.uid, destination);
    } else {
      // should be open dialog in order to make kindly force user to login
      Utility.getInstance().showAlertDialog(
        context: context,
        alertTitle: "Be our valuable member in Seyr Et",
        popButtonText: "Back",
        onPopTap: () => Navigator.of(context).pop(),
        popButtonColor: Colors.redAccent,
        isShowActionButton: true,
        alertMessage: "It is required to sign up before make favorite",
        actionButtonText: "Sign up",
        actionButtonColor: AppColors.buttonBackgroundColor,
        onTapAction: () => Navigator.of(context).pushNamed(
          Wrapper.routeName
          // MaterialPageRoute(
          //     builder: (context) => Wrapper(
          //           isLogin: false,
          //           bottomNavIndex: 3,
          //         )),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    print("Detail Screen");
    final providerData = Provider.of<Destinations>(context, listen: false);
    print(providerData);

    TabController _tabController = TabController(length: 2, vsync: this);
    final clickedDestination =
        ModalRoute.of(context)!.settings.arguments as Destination;
    Map<String, dynamic> mapArgument = {
      "isSelecting": isSelecting,
      "geoPoint": clickedDestination.geoPoint,
      "zoom": 12.0
    };
    void showDestinationOnMap() {
      Navigator.of(context)
          .pushNamed(MapScreen.routeName, arguments: mapArgument);
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Column(
          children: [
            Container(
              width: double.maxFinite,
              height: MediaQuery.of(context).size.height * 0.5,
              color: AppColors.mainColor,
              child: Stack(
                children: [
                  Positioned(
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: MediaQuery.of(context).size.width,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(35),
                        bottomRight: Radius.circular(35),
                      ),
                      child: Image.network(
                        clickedDestination.photoUrl[showImageIndex],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 10,
                    top: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        padding: const EdgeInsets.all(10),
                        primary: AppColors.buttonBackgroundColor,
                      ),
                      child: Icon(
                        Icons.arrow_back,
                        color: AppColors.inputColor,
                      ),
                    ),
                  ),
                  StreamBuilder<QuerySnapshot>(
                      stream: user == null
                          ? null
                          : FireStoreService()
                              .isDestinationFavorite(clickedDestination.id!),
                      builder: (context, snapshot) {
                        print("SANPSHAP");
                        print(snapshot);
                        if (snapshot.connectionState == ConnectionState.none ||
                            snapshot.connectionState ==
                                ConnectionState.active) {
                          return Positioned(
                            top: 40,
                            right: 10,
                            child: ElevatedButton(
                              onPressed: () =>
                                  toggleFavorite(clickedDestination),
                              style: ElevatedButton.styleFrom(
                                shape: const CircleBorder(),
                                padding: const EdgeInsets.all(10),
                                primary: AppColors.buttonBackgroundColor,
                              ),
                              child: !snapshot.hasData ||
                                      snapshot.data!.docs.isEmpty
                                  ? Icon(
                                      Icons.favorite_border_outlined,
                                      color: AppColors.inputColor,
                                    )
                                  : Icon(
                                      Icons.favorite,
                                      color: AppColors.inputColor,
                                    ),
                            ),
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }),
                  Positioned(
                    left: 20,
                    bottom: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppLargeText(
                          text: clickedDestination.name,
                          size: 22,
                          color: AppColors.inputColor,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.place,
                              color: Colors.white,
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              child: AppLightText(
                                text: clickedDestination.region,
                                color: AppColors.inputColor,
                                size: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
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
                            itemCount: clickedDestination.photoUrl.length,
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemBuilder: (context, index) => GestureDetector(
                              onTap: () => verticalListItemClicked(index),
                              child: showImageIndex == index
                                  ? Container(
                                      margin: const EdgeInsets.all(4.0),
                                      width: 50,
                                      height: 50,
                                      // margin: const EdgeInsets.only(bottom: 8),
                                      // padding: EdgeInsets.symmetric(horizontal: 5,vertical: 0),
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
                                          clickedDestination
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
                                          clickedDestination.photoUrl[index],
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
              ),
            ),
            // const SizedBox(height: 30,),
            Container(
              width: double.maxFinite,
              height: MediaQuery.of(context).size.height * 0.45,
              color: AppColors.mainColor,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      DetailInfo(
                        title: 'Distance',
                        info: "54 km",
                      ),
                      DetailInfo(
                        title: "Duration",
                        info: "2.6 h",
                      ),
                      DetailInfo(
                        title: "Rating",
                        info: "3.6 k",
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TabBar(
                      labelPadding: const EdgeInsets.only(left: 20, right: 20),
                      labelColor: AppColors.buttonBackgroundColor,
                      controller: _tabController,
                      isScrollable: true,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicator: CircleTabIndicator(
                        color: AppColors.buttonBackgroundColor,
                        radius: 4,
                      ),
                      unselectedLabelColor:
                          AppColors.buttonBackgroundColor.withOpacity(0.7),
                      tabs: [
                        Tab(
                          child: AppLightText(
                            text: 'Overview',
                            size: 15,
                            color: AppColors.buttonBackgroundColor,
                          ),
                        ),
                        Tab(
                          child: AppLightText(
                            text: 'Review',
                            size: 15,
                            color: AppColors.buttonBackgroundColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 60,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    width: double.infinity,
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        Container(
                          child: AppLightText(
                            text: clickedDestination.overview,
                          ),
                        ),
                        Container(
                          child: AppLightText(
                            text:
                                "Beautiful place with its amazing nature.Live a life. You can take simple cotage here. Just relax and take a time. Something more interested an be motivated",
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  CustomButton(
                    onTap: showDestinationOnMap,
                    buttonText: "View On Map",
                    borderRadius: 20,
                  ),
                  const SizedBox(
                    height: 30,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
