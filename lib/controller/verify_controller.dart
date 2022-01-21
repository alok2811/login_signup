import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:login_signup/helper/dialog_helper.dart';
import 'package:login_signup/view/home_view.dart';

class VerifyController extends GetxController{
  var smsCode =''.obs;
  
  Future<void> submitOTP({required String verificationId, required String smsCode, required String phoneNumber}) async {
    /// get the `smsCode` from the user
    String otp = smsCode.toString().trim();

    AuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: otp,
    );

    try {
      final UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);

      if (userCredential.user != null) {
       DialogHelper.hideLoading();
       Get.offAll(() => HomeView());
        // if (userCredential.additionalUserInfo!.isNewUser) {
        //   Get.offAll(() => UpdateProfileView());
        // }
        // else {
        //   Get.offAll(() => HomeView());
        // }

      } else {
        DialogHelper.hideLoading();
        DialogHelper.showSnackBar(strMsg: 'Sorry, Something wrong!');

      }
    }catch(e){
      DialogHelper.hideLoading();
      DialogHelper.showSnackBar(strMsg: e.toString());
    }

  }
}