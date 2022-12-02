import 'package:flutter/material.dart';
import 'package:travel_app/helpers/app_large_text.dart';
import 'package:travel_app/screen/wrapper.dart';
import 'package:travel_app/services/firebase_firestore_service.dart';
import '../helpers/app_colors.dart';
import '../helpers/custom_button.dart';

class ChangeNameScreen extends StatefulWidget {
  const ChangeNameScreen(
      {required this.firstName, required this.lastName, required this.uid ,Key? key})
      : super(key: key);
  final String firstName;
  final String lastName;
  final String? uid;
  static const routeName = '/change-name';
  @override
  State<ChangeNameScreen> createState() => _ChangeNameScreenState();
}

class _ChangeNameScreenState extends State<ChangeNameScreen> {
  TextEditingController? _firstnameController;
  TextEditingController? _lastnameController;

  bool isShowSaveButton = false;
  final _form = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _firstnameController = TextEditingController(text: widget.firstName);
    _lastnameController = TextEditingController(text: widget.lastName);
  }

  @override
  void dispose() {
    _firstnameController?.dispose();
    _lastnameController?.dispose();
    super.dispose();
  }

  void saveNameChange(){
    String? changedFirstName = _firstnameController?.text;
    String? changedLastName = _lastnameController?.text;
    FireStoreService().updateUserName(changedFirstName, changedLastName, widget.uid);
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
  @override
  Widget build(BuildContext context) {
    // final name =
    //     ModalRoute.of(context)!.settings.arguments as Map<String, String>;

    void saveForm() {
      FocusScope.of(context).unfocus();
      // _form.currentState!.save();
    }

    void checkIfNameChanged(String text) {
      print("checkIfNameChanged");
      if ((widget.firstName != _firstnameController?.text ||
          widget.lastName != _lastnameController?.text) && (_firstnameController?.text!='' && _lastnameController?.text!='')) {
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

    return Scaffold(
      backgroundColor: AppColors.backgroundColorOfApp,
      body: NestedScrollView(
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
                flexibleSpace: const FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(
                    "Change Name",
                    // "Great time to discover",
                    style: TextStyle(color: Colors.black),
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
                    margin:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    // color: AppColors.bu,
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        // const SizedBox(
                        //   height: 20,
                        // ),
                        Form(
                          // key: _form,
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  AppLargeText(
                                    text: "First name",
                                    size: 18,
                                    color: Colors.black,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    controller: _firstnameController,
                                    textInputAction: TextInputAction.done,
                                    keyboardType: TextInputType.name,
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
                                      // hintText: "First name",
                                      prefixIconColor:
                                          AppColors.buttonBackgroundColor,
                                    ),
                                    // initialValue: name.values.first,
                                    onChanged: (value) =>
                                        checkIfNameChanged(value),
                                    onFieldSubmitted: (_) {
                                      saveForm();
                                    },
                                    onSaved: (value) {
                                      // checkEmailIsRegistered(value);
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              Column(
                                children: [
                                  AppLargeText(
                                    text: "Last name",
                                    size: 18,
                                    color: Colors.black,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    controller: _lastnameController,
                                    textInputAction: TextInputAction.done,
                                    keyboardType: TextInputType.name,
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
                                      // hintText: "Surname",
                                      prefixIconColor:
                                          AppColors.buttonBackgroundColor,
                                    ),
                                    onChanged: (value) =>
                                        checkIfNameChanged(value),
                                    onFieldSubmitted: (_) {
                                      saveForm();
                                    },
                                    onSaved: (value) {
                                      // checkEmailIsRegistered(value);
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
                // SliverToBoxAdapter(
                //   child: Container(
                //     height: 130,
                //     color: AppColors.backgroundColorOfApp,
                //   ),
                // ),
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
              onTap: () =>saveNameChange(),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
