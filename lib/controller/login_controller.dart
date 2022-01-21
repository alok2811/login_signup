import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_signup/helper/constants.dart';
import 'package:login_signup/helper/dialog_helper.dart';
import 'package:login_signup/view/home_view.dart';
import 'package:login_signup/view/login_view.dart';
import 'package:login_signup/view/register_view.dart';
import 'package:login_signup/widgets/button_widget.dart';
import 'package:login_signup/widgets/input_widget.dart';

class LoginController extends GetxController{


  var emailController = TextEditingController();
  var forgetEmailController = TextEditingController();
  var passwordController = TextEditingController();

  void loginUser({required String email, required String password}) async {

    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        DialogHelper.showLoading();
        await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);

        homePage();

      } else {
        DialogHelper.showSnackBar(title: 'Error',strMsg: 'Please enter all the fields');

      }
    } catch (e) {
      DialogHelper.showSnackBar(title: 'Error',strMsg: e.toString());

    }
  }


  void forgetEmailDialog() async{

    Get.dialog(
      Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Enter Email",
                style: Get.textTheme.headline4,
              ),
              const SizedBox(height: 10,),
              InputWidget(icon: Icons.email, controller: forgetEmailController, hintText: "Email"),
              const SizedBox(height: 10,),
              ButtonWidget(
                onPress: () {
                  DialogHelper.showLoading();
                  forgotPass(email: forgetEmailController.text);
                },
                buttonText: 'Reset Password', textColor: Colors.white,
                backgroundColor: secondColor,
              ),
            ],
          ),
        ),
      ),
    );

  }

  void forgotPass({required String email}) async {
    if (email.isEmpty) {
      DialogHelper.hideLoading();
      DialogHelper.showSnackBar(strMsg: 'Please fill valid email!');
    } else {

      if (Get.isDialogOpen!) Get.back();
      try {
        await firebaseAuth.sendPasswordResetEmail(
            email: email);
        DialogHelper.hideLoading();
        DialogHelper.showErrorDialog(title: "Reset Password", description:
        "Please check your email and click on the provided link to reset your password.");

      } on FirebaseAuthException catch (e) {
        DialogHelper.hideLoading();
       DialogHelper.showSnackBar(strMsg: e.code);
      } catch (e) {
        DialogHelper.hideLoading();
       DialogHelper.showSnackBar(strMsg: e.toString());
      }
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