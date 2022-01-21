import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_signup/controller/splash_controller.dart';

class SplashView extends StatelessWidget {
   SplashView({Key? key}) : super(key: key);
   final controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("assets/images/logo.png"),
      ),
    );
  }
}
