import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotfire/home_screen/home_view_model.dart';
import 'package:spotfire/login_screen/login_screen.dart';
import 'package:spotfire/login_screen/login_view_model.dart';
import 'package:spotfire/util/instances.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Instances.firebaseApp = await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginViewModel>(
          create: (BuildContext context) => LoginViewModel(),
        ),
        ChangeNotifierProvider<HomeViewModel>(
          create: (BuildContext context) => HomeViewModel(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stop Fire',
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
