import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/model/user_credentials.dart';
import 'package:travel_app/reusable/custom_nested_scroll_view.dart';
import 'package:travel_app/reusable/custom_text_form_field.dart';
import 'package:travel_app/screen/user_info.dart';
import '../helpers/app_colors.dart';
import '../helpers/app_light_text.dart';
import '../helpers/custom_button.dart';

class PasswordScreen extends StatefulWidget {
  static const routeName = '/password';
  const PasswordScreen({Key? key}) : super(key: key);

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final _form = GlobalKey<FormState>();
  final _passwordFocusNode = FocusNode();
  final _passwordController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _innerListIsScrolled = false;
  bool _isShowContinueButton = false;
  bool _minimumPasswordLength = false;
  bool _atLeastOneNumber = false;
  bool _atLeastOneLowerCase = false;
  bool _atLeastOneUpperCase = false;
  bool _isObscure = true;

  Key _key = const PageStorageKey({});
  void saveForm() {
    //check in firebase email is registered or not
    FocusScope.of(context).unfocus();
    _form.currentState!.save();
  }

  void toggleObscure() {
    setState(() {
      _isObscure = !_isObscure;
    });
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
        _key = const PageStorageKey({});
      });
    }
  }

  void checkPasswordValidations(String character) {
    print(character);
    print(_passwordController.text.length);
    if (_passwordController.text.length >= 6) {
      setState(() {
        _minimumPasswordLength = true;
      });
    } else {
      setState(() {
        _minimumPasswordLength = false;
      });
    }
    if (RegExp("(?=.*[a-z])").hasMatch(character)) {
      _atLeastOneLowerCase = true;
    }
    if (!RegExp("(?=.*[a-z])").hasMatch(_passwordController.text)) {
      _atLeastOneLowerCase = false;
    }
    if (RegExp("(?=.*[A-Z])").hasMatch(character)) {
      _atLeastOneUpperCase = true;
    }
    if (!RegExp("(?=.*[A-Z])").hasMatch(_passwordController.text)) {
      _atLeastOneUpperCase = false;
    }
    if (RegExp((r'\d')).hasMatch(character)) {
      _atLeastOneNumber = true;
    }
    if (!RegExp((r'\d')).hasMatch(_passwordController.text)) {
      _atLeastOneNumber = false;
    }
    if (_minimumPasswordLength &&
        _atLeastOneNumber &&
        _atLeastOneLowerCase &&
        _atLeastOneUpperCase) {
      _isShowContinueButton = true;
    } else {
      _isShowContinueButton = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    print("args");
    print(args);

    void goNextScreen(value) async {
      if (!args['provider'] && _isShowContinueButton) {
        Navigator.pushNamed(
          context,
          UserInfo.routeName,
          arguments: UserCredentials(
            args['email'],
            value,
          ),
        );
      }
    }

    return Scaffold(
      backgroundColor: AppColors.backgroundColorOfApp,
      body: CustomNestedScrollView(
        title: 'please_set_password_title'.tr(),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            AppLightText(
              spacing: 16,
              text: "'welcome_msg'.tr() ${args['email']}",
              padding: EdgeInsets.zero,
            ),
            const SizedBox(
              height: 10,
            ),
            Form(
              key: _form,
              child: Column(
                children: [
                  AppLightText(
                    text: 'password_title'.tr(),
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
                        FocusScope.of(context).requestFocus(_passwordFocusNode);
                      }
                    },
                    child: CustomTextFormField(
                      controller: _passwordController,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.done,
                      focusNode: _passwordFocusNode,
                      onChanged: (value) => checkPasswordValidations(value),
                      onSaved: (value) => goNextScreen(value),
                      onFieldSubmitted: (_) => saveForm(),
                      obscureText: _isObscure,
                      suffixIcon: GestureDetector(
                        onTap: () => toggleObscure(),
                        child: _isObscure
                            ? const Icon(Icons.remove_red_eye_outlined)
                            : const Icon(Icons.remove_red_eye),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            AppLightText(
              spacing: 16,
              text: 'minimum_of_6_characters_validation'.tr(),
              isShowIcon: true,
              icon: Container(
                width: 10,
                height: 10,
                margin: const EdgeInsets.only(right: 5),
                child: Icon(
                  Icons.check,
                  color:
                      _minimumPasswordLength ? Colors.redAccent : Colors.black,
                ),
              ),
              padding: EdgeInsets.zero,
            ),
            AppLightText(
              spacing: 16,
              text: 'at_least_one_lower_case_validation'.tr(),
              isShowIcon: true,
              icon: Container(
                width: 10,
                height: 10,
                margin: const EdgeInsets.only(right: 5),
                child: Icon(
                  Icons.check,
                  color: _atLeastOneLowerCase ? Colors.redAccent : Colors.black,
                ),
              ),
              padding: EdgeInsets.zero,
            ),
            AppLightText(
              spacing: 16,
              text: 'at_least_one_upper_case_validation'.tr(),
              isShowIcon: true,
              icon: Container(
                width: 10,
                height: 10,
                margin: const EdgeInsets.only(right: 5),
                child: Icon(
                  Icons.check,
                  color: _atLeastOneUpperCase ? Colors.redAccent : Colors.black,
                ),
              ),
              padding: EdgeInsets.zero,
            ),
            AppLightText(
              spacing: 16,
              text: 'at_least_one_number_validation'.tr(),
              isShowIcon: true,
              icon: Container(
                width: 10,
                height: 10,
                margin: const EdgeInsets.only(right: 5),
                child: Icon(
                  Icons.check,
                  color: _atLeastOneNumber ? Colors.redAccent : Colors.black,
                ),
              ),
              padding: EdgeInsets.zero,
            ),
          ],
        ),
      ),
      floatingActionButton: _isShowContinueButton
          ? CustomButton(
              buttonText: 'continue_btn'.tr(),
              borderRadius: 15,
              horizontalMargin: 20,
              onTap: saveForm,
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
