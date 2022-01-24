import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login_signup/helper/constants.dart';
import 'package:login_signup/helper/dialog_helper.dart';
import 'package:login_signup/view/home_view.dart';
import 'package:login_signup/view/login_view.dart';
import 'package:login_signup/view/phone_auth_view.dart';
import 'package:login_signup/view/register_view.dart';

class WelcomeController extends GetxController{

  void loginPage(){
    Get.to(() => LoginView());
  }

  void registerPage(){
    Get.to(() => RegisterView());
  }

  void phoneAuthPage(){
    Get.to(() => PhoneAuthView());
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

          String? token = await FirebaseMessaging.instance.getToken();

          saveUserDetails(uid: userCredential.user!.uid,
              token: token, username: userCredential.user!.displayName,
              email: userCredential.user!.email, password: "password");

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

  void loginWithFacebook(var result) async {
    try {
      DialogHelper.showLoading();
      final AuthCredential facebookCredential =
      FacebookAuthProvider.credential(result.accessToken.token);
      final userCredential =
      await firebaseAuth.signInWithCredential(facebookCredential);

      if (userCredential.user != null) {
        DialogHelper.hideLoading();
        String? token = await FirebaseMessaging.instance.getToken();
        saveUserDetails(uid: userCredential.user!.uid,
            token: token, username: userCredential.user!.displayName,
            email: userCredential.user!.email, password: "password");

        Get.offAll(() => HomeView());

        // if (userCredential.additionalUserInfo.isNewUser) {
        //   writeData();
        // }
        // else {
        //   await loginDetail();
        //   CustomMethod.closeLoaderDialog(context);
        //   Navigator.pushReplacement(
        //       context,
        //       MaterialPageRoute(builder: (context) => const HomePageView()));
        // }
      } else {
        DialogHelper.hideLoading();
        DialogHelper.showSnackBar(strMsg: 'Sorry, Something wrong!');
      }
    } on FirebaseAuthException catch (e) {
      DialogHelper.hideLoading();
      if (e.code == 'account-exists-with-different-credential') {
       DialogHelper.showSnackBar(strMsg: 'The account already exists with a different credential.');
      } else if (e.code == 'invalid-credential') {
        print(e.message);
        DialogHelper.showSnackBar(strMsg: e.message!);
      }
    } catch (e) {
      DialogHelper.hideLoading();
      DialogHelper.showSnackBar(strMsg: e.toString());
    }
  }

  void handleLogin() async {
    final LoginResult result = await FacebookAuth.instance.login();
    switch (result.status) {
      case LoginStatus.cancelled:
        break;
      case LoginStatus.failed:
        break;
      case LoginStatus.success:
        try {
          loginWithFacebook(result);
        } catch (e) {
          DialogHelper.showSnackBar(strMsg: e.toString());
        }
        break;
      case LoginStatus.operationInProgress:

        break;
    }
  }

  void saveUserDetails({required uid, username, email, password, token}) async {
    await fireStore
        .collection('users')
        .doc(uid)
        .set({
      "name": username,
      "email": email,
      "password": password,
      "token": token,
    });
  }

}