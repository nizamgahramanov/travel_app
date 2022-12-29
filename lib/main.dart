import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/helpers/app_colors.dart';
import 'package:travel_app/providers/destinations.dart';
import 'package:travel_app/providers/language.dart';
import 'package:travel_app/reusable/custom_page_route.dart';
import 'package:travel_app/screen/add_destination_screen.dart';
import 'package:travel_app/screen/detail_screen.dart';
import 'package:travel_app/screen/change_password_screen.dart';
import 'package:travel_app/screen/login_signup_screen.dart';
import 'package:travel_app/screen/login_with_password_screen.dart';
import 'package:travel_app/screen/maps_screen.dart';
import 'package:travel_app/screen/password_screen.dart';
import 'package:travel_app/screen/profile_screen.dart';
import 'package:travel_app/screen/start_screen.dart';
import 'package:travel_app/screen/user_info.dart';
import 'package:travel_app/services/auth_service.dart';
import 'package:travel_app/services/network_service.dart';

import 'helpers/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('az', 'Latn'),
      ],
      fallbackLocale: const Locale('en', 'US'),
      path: 'assets/translations',
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case DetailScreen.routeName:
        return CustomPageRoute(
          child: DetailScreen(),
          settings: settings,
        );
      case PasswordScreen.routeName:
        return CustomPageRoute(
          child: const PasswordScreen(),
          settings: settings,
        );
      case UserInfo.routeName:
        return CustomPageRoute(
          child: UserInfo(),
          settings: settings,
        );
      case ProfileScreen.routeName:
        return CustomPageRoute(
          child: ProfileScreen(),
          settings: settings,
        );
      case ChangePasswordScreen.routeName:
        return CustomPageRoute(
          child: ChangePasswordScreen(),
          settings: settings,
        );
      case AddDestinationScreen.routeName:
        return CustomPageRoute(
          child: const AddDestinationScreen(),
          settings: settings,
        );
      case MapScreen.routeName:
        return CustomPageRoute(
          child: MapScreen(),
          settings: settings,
        );
      case LoginSignupScreen.routeName:
        return CustomPageRoute(
          child: const LoginSignupScreen(),
          settings: settings,
        );
      case LoginWithPasswordScreen.routeName:
        return CustomPageRoute(
          child: LoginWithPasswordScreen(),
          settings: settings,
        );
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Destinations(),
        ),
        ChangeNotifierProvider(
          create: (_) => Language(),
        ),
        Provider<AuthService>(
          create: (_) => AuthService(),
        ),
        StreamProvider(
          create: (context) => NetworkService().controller.stream,
          initialData: NetworkStatus.offline,
        )
      ],
      child: MaterialApp(
        title: materialAppTitle,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: AppColors.primaryColorOfApp,
              secondary: AppColors.blackColor38),
          textSelectionTheme: const TextSelectionThemeData(
            selectionColor: AppColors.primaryColorOfApp,
            cursorColor: AppColors.primaryColorOfApp,
            selectionHandleColor: AppColors.primaryColorOfApp,
          ),
        ),
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        home: const StartScreen(),
        onGenerateRoute: (route) => onGenerateRoute(route),
      ),
    );
  }
}
