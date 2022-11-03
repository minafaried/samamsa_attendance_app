import 'package:attendance_app/features/Authentication/controller/userController.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Common/Config/Palette.dart';
import 'Common/Config/Routing.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserController>(
        create: (BuildContext context) => UserController(),
        child: MaterialApp(
          title: 'الحضور',
          color: Palette.primaryColor1,
          theme: ThemeData(
            backgroundColor: Palette.primaryColor1,
          ),
          initialRoute: "/",
          onGenerateRoute: RouteGenerator.generateRoute,
        ));
  }
}
