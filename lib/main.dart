import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_signup/view/splash_view.dart';
import 'package:login_signup/view/welcome_view.dart';
import 'helper/constants.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Login SignUp',
      theme: ThemeData(
        primarySwatch: primaryMaterialColor,
      ),
      darkTheme: ThemeData.dark(),
      home: SplashView(),
    );
  }
}


