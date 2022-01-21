import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_signup/controller/home_controller.dart';
import 'package:login_signup/widgets/button_widget.dart';
import 'package:login_signup/widgets/input_widget.dart';

class HomeView extends StatelessWidget {
   HomeView({Key? key}) : super(key: key);
   final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: ButtonWidget(
          textColor: Colors.white, backgroundColor: Colors.red, onPress: () {
            controller.logOutUser();
        }, buttonText: 'Logout',),
      ),
    );
  }
}
