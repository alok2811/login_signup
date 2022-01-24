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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

           Obx(() => Text(controller.title.value)),
          const SizedBox(height: 5,),
          Obx(() =>  Text(controller.body.value)),

            const SizedBox(height: 5,),
            Obx(() =>  Text(controller.type.value)),

            ButtonWidget(
              textColor: Colors.white, backgroundColor: Colors.blue, onPress: () {
                controller.sendNotification("dYnrYF4XQuqssZYt1Cb5wg:APA91bGUg8A-L2ViI0XmXG9hLJLx90ttwzdUVZBZAHqkeiZWcIYI1-NsGNeIfKKM_PlXBvS02kvdWxrAFR0-40_AsvklxNin5FAeOcU1Y72yPGX6tWMmrqbSpVd_3xN0KuRIxvxhohdi",
                    "Alok Dubey", "Message from IOS app");
            }, buttonText: 'Send Notification',),
            ButtonWidget(
              textColor: Colors.white, backgroundColor: Colors.red, onPress: () {
                controller.logOutUser();
            }, buttonText: 'Logout',),
          ],
        ),
      ),
    );
  }
}
