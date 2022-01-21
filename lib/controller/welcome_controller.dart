import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login_signup/helper/constants.dart';
import 'package:login_signup/helper/dialog_helper.dart';
import 'package:login_signup/view/home_view.dart';
import 'package:login_signup/view/login_view.dart';
import 'package:login_signup/view/register_view.dart';

class WelcomeController extends GetxController{

  void loginPage(){
    Get.to(() => LoginView());
  }

  void registerPage(){
    Get.to(() => RegisterView());
  }

  void googleSignIn() async {
    try {
      var googleSignInAccount = await GoogleSignIn().signIn();

      if (googleSignInAccount != null) {
        DialogHelper.showLoading();
        GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        final UserCredential userCredential =
        await firebaseAuth.signInWithCredential(credential);
        if (userCredential.user != null) {
          DialogHelper.hideLoading();
          Get.offAll(() => HomeView());

          // if (userCredential.additionalUserInfo!.isNewUser) {
          //   writeData();
          // }
          // else {
          //   loginDetail();
          //
          // }
        } else {
          DialogHelper.hideLoading();
          DialogHelper.showSnackBar(strMsg: 'Sorry, Something wrong!');
        }
      }
    } on FirebaseAuthException catch (e) {
      DialogHelper.hideLoading();

      if (e.code == 'account-exists-with-different-credential') {
        DialogHelper.showSnackBar(strMsg: 'The account already exists with a different credential.');
      } else if (e.code == 'invalid-credential') {
        DialogHelper.showSnackBar(strMsg: 'Sorry, Credentials error. Try again.');
      }
    } catch (e) {
      DialogHelper.hideLoading();
      DialogHelper.showSnackBar(strMsg: e.toString());
    }
  }




}