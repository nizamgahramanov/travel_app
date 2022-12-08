import 'package:flutter/material.dart';
import 'package:travel_app/helpers/app_colors.dart';
import 'package:travel_app/services/auth_service.dart';

import '../helpers/app_light_text.dart';
import '../helpers/custom_button.dart';
import '../model/user_credentials.dart';

class UserInfo extends StatefulWidget {
  static const routeName = '/user_info';
  UserInfo({
    Key? key,
  }) : super(key: key);

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  final _form = GlobalKey<FormState>();
  final _lastnameFocusNode = FocusNode();
  final _firstnameFocusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  bool _innerListIsScrolled = false;
  Key _key = const PageStorageKey({});
  bool _isShowSaveButton = false;
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
        _key = PageStorageKey({});
      });
    }
  }
  void checkIfNameChanged(String text) {
    print("checkIfNameChanged");
    if (_firstnameController.text != '' && _lastnameController.text != '') {
      setState(() {
        print("isShow");
        print(_isShowSaveButton);
        _isShowSaveButton = true;
      });
    } else {
      setState(() {
        print("isShow");
        print(_isShowSaveButton);
        _isShowSaveButton = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_updateScrollPosition);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateScrollPosition);
    _firstnameController.dispose();
    _lastnameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as UserCredentials;
    print(args.email);
    print("KLKLKRE");
    void registerUser() async {
      if(_isShowSaveButton){
        AuthService().registerUser(
          context: context,
          firstName: _firstnameController.text,
          lastName: _lastnameController.text,
          email: args.email,
          password: args.password,
        );
      }
      // I think this approach is not correct
      // Navigator.pushNamedAndRemoveUntil(
      //     context, MainScreen.routeName, (route) => false);
    }

    void saveForm() {
      print("SSAVE FORRM");
      FocusScope.of(context).unfocus();
      _form.currentState!.save();
    }

    return Scaffold(
      backgroundColor: AppColors.backgroundColorOfApp,
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
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
                      ? const Text(
                          "LET'S GET KNOW",
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
                    height: MediaQuery.of(context).size.height * 0.7,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 0,
                    ),
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
                                    onSaved: (_){
                                      registerUser();
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
      floatingActionButton: _isShowSaveButton ?CustomButton(
        buttonText: "Done",
        borderRadius: 15,
        horizontalMargin: 20,
        verticalMargin: 20,
        onTap: saveForm,
      ) : null,
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
            text: "LET'S GET TO KNOW",
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
