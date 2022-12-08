import 'package:flutter/material.dart';
import 'package:travel_app/helpers/app_light_text.dart';
import 'package:travel_app/screen/wrapper.dart';
import 'package:travel_app/services/auth_service.dart';
import 'package:travel_app/services/firebase_firestore_service.dart';
import '../helpers/app_colors.dart';
import '../helpers/custom_button.dart';

class ChangeNameScreen extends StatefulWidget {
  const ChangeNameScreen({
    required this.firstName,
    required this.lastName,
    required this.uid,
    Key? key,
  }) : super(key: key);
  final String firstName;
  final String lastName;
  final String? uid;
  static const routeName = '/change-name';
  @override
  State<ChangeNameScreen> createState() => _ChangeNameScreenState();
}

class _ChangeNameScreenState extends State<ChangeNameScreen>
    with TickerProviderStateMixin {
  final _lastnameFocusNode = FocusNode();
  final _firstnameFocusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();
  TextEditingController? _firstnameController;
  TextEditingController? _lastnameController;
  bool _innerListIsScrolled = false;
  Key _key = const PageStorageKey({});
  bool isShowSaveButton = false;
  final _form = GlobalKey<FormState>();

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
        // Reset scroll positions of the TabBarView pages
        _key = PageStorageKey({});
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // FocusScope.of(context).requestFocus(FocusNode());
    _scrollController.addListener(_updateScrollPosition);
    _firstnameController = TextEditingController(text: widget.firstName);
    _lastnameController = TextEditingController(text: widget.lastName);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateScrollPosition);
    _firstnameController?.dispose();
    _lastnameController?.dispose();
    super.dispose();
  }

  void saveNameChange() async {
    FocusScope.of(context).unfocus();
    String? changedFirstName = _firstnameController?.text;
    String? changedLastName = _lastnameController?.text;
    await AuthService()
        .updateUserName(changedFirstName, changedLastName)
        .then((value) {
      if (value) {
        FireStoreService()
            .updateUserName(changedFirstName, changedLastName, widget.uid);
      }
    });
    print(changedFirstName);
    print(changedLastName);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Wrapper(
          isLogin: true,
          bottomNavIndex: 3,
        ),
      ),
    );
  }

  void checkIfNameChanged(String text) {
    print("checkIfNameChanged");
    if ((widget.firstName != _firstnameController?.text ||
            widget.lastName != _lastnameController?.text) &&
        (_firstnameController?.text != '' && _lastnameController?.text != '')) {
      setState(() {
        print("isShow");
        print(isShowSaveButton);
        isShowSaveButton = true;
      });
    } else {
      setState(() {
        print("isShow");
        print(isShowSaveButton);
        isShowSaveButton = false;
      });
    }
  }

  void saveForm() {
    print("SAVE FORM");
    FocusScope.of(context).unfocus();
    // _form.currentState!.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColorOfApp,
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          print("_innerListIsScrolled");
          print(_innerListIsScrolled);
          return <Widget>[
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                leading: InkWell(
                  onTap: () {
                    FocusScope.of(context).unfocus();
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
                  collapseMode: CollapseMode.pin,
                  centerTitle: false,
                  title: _innerListIsScrolled
                      ? Text(
                          "CHANGE NAME",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                          ),
                        )
                      : null,
                  background: MyBackground(),
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
                    margin:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    // color: AppColors.bu,
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Form(
                          key: _form,
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  AppLightText(
                                    text: "First name",
                                    size: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    spacing: 2,
                                    padding: EdgeInsets.zero,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Focus(
                                    autofocus: true,
                                    onFocusChange: (bool inFocus) {
                                      if (inFocus) {
                                        FocusScope.of(context)
                                            .requestFocus(_firstnameFocusNode);
                                      }
                                    },
                                    child: TextFormField(
                                      controller: _firstnameController,
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.name,
                                      focusNode: _firstnameFocusNode,
                                      enableSuggestions: true,
                                      autocorrect: true,
                                      decoration: InputDecoration(
                                        filled: true,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color:
                                                AppColors.buttonBackgroundColor,
                                            width: 2,
                                          ),
                                        ),
                                        prefixIconColor:
                                            AppColors.buttonBackgroundColor,
                                      ),
                                      onChanged: (value) =>
                                          checkIfNameChanged(value),
                                      onFieldSubmitted: (_) {
                                        FocusScope.of(context)
                                            .requestFocus(_lastnameFocusNode);
                                      },
                                      onSaved: (value) {
                                        // checkEmailIsRegistered(value);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              Column(
                                children: [
                                  AppLightText(
                                    text: "Last name",
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
                                    controller: _lastnameController,
                                    textInputAction: TextInputAction.done,
                                    keyboardType: TextInputType.name,
                                    focusNode: _lastnameFocusNode,
                                    enableSuggestions: true,
                                    autocorrect: true,
                                    decoration: InputDecoration(
                                      filled: true,
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        // borderSide: BorderSide.none,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                              AppColors.buttonBackgroundColor,
                                          width: 2,
                                        ),
                                      ),
                                      prefixIconColor:
                                          AppColors.buttonBackgroundColor,
                                    ),
                                    onChanged: (value) =>
                                        checkIfNameChanged(value),
                                    onFieldSubmitted: (_) {
                                      saveForm();
                                    },
                                    onSaved: (_) {
                                      saveForm();
                                    },
                                  ),
                                ],
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
      floatingActionButton: isShowSaveButton
          ? CustomButton(
              buttonText: "Done",
              borderRadius: 15,
              horizontalMargin: 20,
              verticalMargin: 5,
              onTap: () => saveNameChange(),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class MyBackground extends StatefulWidget {
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
            text: "CHANGE NAME",
            size: 28,
            color: Colors.black,
            fontWeight: FontWeight.bold,
            spacing: 2,
            padding: EdgeInsets.zero,
          )
        ],
      ),
    );
  }
}

// class NoScalingAnimation extends FloatingActionButtonAnimator {
//   double? _x;
//   double? _y;
//   @override
//   Offset getOffset(
//       {required Offset begin, required Offset end, required double progress}) {
//     _x = begin.dx + (end.dx - begin.dx) * progress;
//     _y = begin.dy + (end.dy - begin.dy) * progress;
//     print('x offset');
//     print(_x);
//     print('y offset');
//     print(_y);
//     return end;
//   }
//
//   @override
//   Animation<double> getRotationAnimation({required Animation<double> parent}) {
//     print('getRotationAnimation');
//     return Tween<double>(begin: 0.5, end: 1.0).animate(parent);
//   }
//
//   @override
//   Animation<double> getScaleAnimation({required Animation<double> parent}) {
//     print('getScaleAnimation');
//     return Tween<double>(begin: 1.0, end: 1.0).animate(parent);
//   }
// }
