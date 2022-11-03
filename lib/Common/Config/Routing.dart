import 'package:attendance_app/features/Authentication/view/pages/authPage.dart';
import 'package:attendance_app/features/Home/controller/mempersController.dart';
import 'package:attendance_app/features/Home/view/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => AuthPage());
      case '/home':
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider<MempersController>(
                  create: (BuildContext context) => MempersController(),
                  child: HomePage(),
                ));
      default:
        return MaterialPageRoute(builder: (_) => AuthPage());
    }
  }
}
