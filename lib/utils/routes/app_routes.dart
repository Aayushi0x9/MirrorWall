import 'package:flutter/material.dart';
import 'package:morror_wall/home/home_page.dart';

class AppRoutes {
  static const String home = '/';

  static Map<String, WidgetBuilder> routes = {
    AppRoutes.home: (context) => const HomePage(),
  };
}
