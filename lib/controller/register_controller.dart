import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:login_signup/helper/constants.dart';
import 'package:login_signup/helper/dialog_helper.dart';
import 'package:login_signup/view/home_view.dart';
import 'package:login_signup/view/login_view.dart';
import 'package:login_signup/view/register_view.dart';

class RegisterController extends GetxController{

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  void registerUser({required String username, required String email, required String password}) async {

    try {
      if (username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty) {
        DialogHelper.showLoading();
        // save out user to our ath and firebase firestore
        UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        await fireStore
            .collection('users')
            .doc(cred.user!.uid)
            .set({
          "name": username,
          "email" : email,
          "password" : password,
        });

        homePage();

      } else {

        DialogHelper.showSnackBar(title: 'Error',strMsg: 'Please enter all the fields');

      }
    } catch (e) {
      DialogHelper.hideLoading();
      DialogHelper.showSnackBar(strMsg: e.toString(), title: "Error");
    }
  }

  void loginPage(){
    Get.to(() => LoginView());
  }

  void registerPage(){
    Get.to(() => RegisterView());
  }

  void homePage(){
    DialogHelper.hideLoading();
    Get.offAll(() => HomeView());
  }
}