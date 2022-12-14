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
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();
  FlutterError.onError = (errorDetails) {
    // If you wish to record a "non-fatal" exception, please use `FirebaseCrashlytics.instance.recordFlutterError` instead
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // PlatformDispatcher.instance.onError = (error, stack) {
  //   // If you wish to record a "non-fatal" exception, please remove the "fatal" parameter
  //   FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
  //   return true;
  // };
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('az', 'Latn'),
      ],
      fallbackLocale: Locale('en', 'US'),
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
      // case MainScreen.routeName:
      //   return CustomPageRoute(
      //     child: MainScreen(),
      //     settings: settings,
      //   );
      case PasswordScreen.routeName:
        print("PASSWORD GO ");
        print(settings);
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
      // case ChangeEmailScreen.routeName:
      //   return CustomPageRoute(
      //     child: const ChangeEmailScreen(),
      //     settings: settings,
      //   );
      // case ChangeNameScreen.routeName:
      //   return CustomPageRoute(
      //     child: const ChangeNameScreen(),
      //     settings: settings,
      //   );
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

  // void toggleFavorite(String id) {
  //   print("TOGGLE FAVORITE");
  //   final existingIndex = favorites.indexWhere((element) => element.id == id);
  //   if (existingIndex >= 0) {
  //     setState(() {
  //       favorites.removeAt(existingIndex);
  //     });
  //   } else {
  //     setState(() {
  //       // favorites.add(destinations.firstWhere((element) => element.id == id));
  //     });
  //   }
  // }

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
          initialData: NetworkStatus.online,
        )
      ],
      child: MaterialApp(
        title: materialAppTitle,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: AppColors.buttonBackgroundColor,
              secondary: AppColors.blackColor38),
          textSelectionTheme: TextSelectionThemeData(
            selectionColor: AppColors.buttonBackgroundColor,
            cursorColor: AppColors.buttonBackgroundColor,
            selectionHandleColor: AppColors.buttonBackgroundColor,
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
