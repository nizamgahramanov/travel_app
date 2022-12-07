import 'package:flutter/material.dart';
import 'package:travel_app/screen/wrapper.dart';
import 'package:travel_app/services/en_de_cryption.dart';
import '../helpers/app_colors.dart';
import '../helpers/app_large_text.dart';
import '../helpers/custom_button.dart';
import '../helpers/utility.dart';
import '../services/auth_service.dart';
import '../services/firebase_firestore_service.dart';

class ChangeEmailScreen extends StatefulWidget {
  const ChangeEmailScreen({
    required this.email,
    required this.password,
    required this.uid,
    Key? key,
  }) : super(key: key);
  final String email;
  final String? password;
  final String? uid;
  static const routeName = '/change-email';
  @override
  State<ChangeEmailScreen> createState() => _ChangeEmailScreenState();
}

class _ChangeEmailScreenState extends State<ChangeEmailScreen> {
  TextEditingController? _emailController;
  TextEditingController? _passwordController;
  bool _isObscure = true;
  final _passwordFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();
  bool _innerListIsScrolled = false;
  bool isShowSaveButton = false;
  Key _key = const PageStorageKey({});

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

  void checkIfEmailChanged(String text) {
    print("checkIfNameChanged");
    if (widget.email != _emailController?.text &&
        // widget.password == _passwordController?.text &&
        _emailController?.text != '' &&
        _passwordController?.text != '') {
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

  void toggleObscure() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_updateScrollPosition);
    _emailController = TextEditingController(text: widget.email);
    _passwordController = TextEditingController();
  }

  void saveForm() {
    FocusScope.of(context).unfocus();
    // _form.currentState!.save();
  }

  void saveEmailChange() async {
    String? enteredEmail = _emailController?.text;
    String? enteredPassword = _passwordController?.text;
    bool isPasswordCorrect =
        EnDeCryption().isPasswordCorrect(enteredPassword!, widget.password!);
    if (isPasswordCorrect) {
      await AuthService()
          .updateUserEmail(enteredEmail, enteredPassword)
          .then((value) {
        if (value != null) {
          FireStoreService().updateUserEmail(enteredEmail, widget.uid);
        } else {
          Utility.getInstance().showAlertDialog(
            popButtonColor: Colors.red,
            context: context,
            alertTitle: "Something unknown occurred",
            alertMessage: "Please check and try again",
            popButtonText: "Ok",
            onPopTap: () => Navigator.of(context).pop(),
          );
        }
      });
      print(enteredEmail);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Wrapper(
            isLogin: true,
            bottomNavIndex: 3,
          ),
        ),
      );
    } else {
      Utility.getInstance().showAlertDialog(
        popButtonColor: Colors.red,
        context: context,
        alertTitle: "Password is correct",
        alertMessage: "Please check and try again",
        popButtonText: "Ok",
        onPopTap: () => Navigator.of(context).pop(),
      );
    }
    // print(changedLastName);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateScrollPosition);
    _emailController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                    Navigator.of(context).pop();
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                backgroundColor: Colors.white,
                pinned: true,
                //floating: true,
                stretch: true,
                expandedHeight: 120.0,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  centerTitle: false,
                  title: _innerListIsScrolled
                      ? const Text(
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
                    color: AppColors.backgroundColorOfApp,
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Form(
                          // key: _form,
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  AppLargeText(
                                    text: "Email",
                                    size: 18,
                                    color: Colors.black,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Focus(
                                    autofocus: true,
                                    onFocusChange: (bool inFocus) {
                                      if (inFocus) {
                                        FocusScope.of(context)
                                            .requestFocus(_emailFocusNode);
                                      }
                                    },
                                    child: TextFormField(
                                      controller: _emailController,
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.emailAddress,
                                      focusNode: _emailFocusNode,
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
                                          checkIfEmailChanged(value),
                                      onFieldSubmitted: (_) {
                                        FocusScope.of(context)
                                            .requestFocus(_passwordFocusNode);
                                      },
                                      onSaved: (value) {
                                        // checkIfEmailChanged(value!);
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
                                  AppLargeText(
                                    text: "Current Password",
                                    size: 18,
                                    color: Colors.black,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    controller: _passwordController,
                                    textInputAction: TextInputAction.done,
                                    keyboardType: TextInputType.text,
                                    focusNode: _passwordFocusNode,
                                    enableSuggestions: false,
                                    autocorrect: false,
                                    obscureText: _isObscure,
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
                                      suffixIcon: GestureDetector(
                                        onTap: () => toggleObscure(),
                                        child: _isObscure
                                            ? const Icon(
                                                Icons.remove_red_eye_outlined)
                                            : const Icon(Icons.remove_red_eye),
                                      ),
                                      suffixIconColor:
                                          AppColors.buttonBackgroundColor,
                                      // focusColor: AppColors.buttonBackgroundColor
                                    ),
                                    onChanged: (value) =>
                                        checkIfEmailChanged(value),
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
              buttonText: "DONE",
              borderRadius: 15,
              margin: 20,
              onTap: () => saveEmailChange(),
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
          AppLargeText(
            text: "CHANGE EMAIL",
            size: 28,
            color: Colors.black,
          )
        ],
      ),
    );
  }
}
