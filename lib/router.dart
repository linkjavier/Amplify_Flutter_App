import 'package:flutter/material.dart';
import 'package:zitro_connect_v1/UI/pages/homePage.dart';
import 'package:zitro_connect_v1/UI/pages/loginPage.dart';
import 'package:zitro_connect_v1/UI/pages/servicesPage.dart';

class AppRouter {
  // All the routes
  static const String ROUTE_LOGIN = '/';
  static const String ROUTE_HOME = '/home';
  static const String ROUTE_SERVICES = '/services';

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case ROUTE_LOGIN:
        return MaterialPageRoute(builder: (_) => const EntryScreen());
      case ROUTE_HOME:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case ROUTE_SERVICES:
        return MaterialPageRoute(builder: (_) => const ServicesPage());
      default:
        return null;
    }
  }
}
