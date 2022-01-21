import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login_signup/helper/constants.dart';
import 'package:login_signup/view/welcome_view.dart';

class HomeController extends GetxController{

  void logOutUser() async{
    var provider = firebaseAuth.currentUser!.providerData[0].providerId;
    GoogleSignIn googleSignIn = new GoogleSignIn();
    await firebaseAuth.signOut();
    if(provider == 'google.com'){
      await googleSignIn.signOut();
    }else if(provider == 'facebook.com'){
     // await FacebookAuth.instance.logOut();
    }

    welcomePage();
  }

  void welcomePage(){
    Get.offAll(()=> WelcomeView());
  }

}