import 'package:flutter/material.dart';
import 'package:icook_mobile/core/managers/core_manager.dart';
import 'package:icook_mobile/core/services/key_storage/key_storage_service.dart';
import 'package:icook_mobile/locator.dart';
import 'package:icook_mobile/provider_setup.dart';
import 'package:icook_mobile/ui/Onboarding_screens/Onboarding_screens.dart';
import 'package:icook_mobile/ui/router.dart';
import 'package:icook_mobile/ui/search_screen/search_page.dart';
import 'package:icook_mobile/ui/splash_screen/splash_screen.dart';

import 'package:icook_mobile/ui/ui_helper.dart';
import 'package:provider/provider.dart';
import 'package:stacked_services/stacked_services.dart';

import 'ui/dish_screen/dish_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final navigationService = locator<NavigationService>();
  final keystorage = locator<KeyStorageService>();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: CoreManager(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: Constants.appName,
          theme: Constants.darkTheme,
          darkTheme: Constants.darkTheme,
          onGenerateRoute: Router.generateRoute,
          navigatorKey: navigationService.navigatorKey,
          home: SplashScreen(),
        ),
      ),
    );
  }
}

class TestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}
