import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:login_signup/helper/constants.dart';
import 'package:login_signup/view/home_view.dart';
import 'package:login_signup/view/login_view.dart';
import 'package:login_signup/view/welcome_view.dart';

class SplashController extends GetxController{


   var user = firebaseAuth.currentUser;


  @override
  void onInit() {
    // TODO: implement onInit
    Future.delayed(const Duration(seconds: 3), () {
      if(user != null){
        Get.off(() => HomeView());
      }else{
        Get.off(() => WelcomeView());
      }
    }
    );
    super.onInit();
  }

}