import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_signup/controller/register_controller.dart';
import 'package:login_signup/helper/constants.dart';
import 'package:login_signup/widgets/button_widget.dart';
import 'package:login_signup/widgets/input_widget.dart';

class RegisterView extends StatelessWidget {
   RegisterView({Key? key}) : super(key: key);
   final controller = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          automaticallyImplyLeading: false,
          actions: [
            TextButton(onPressed: () => Get.back(), child: const Text("Back", style: TextStyle(color: Colors.black))),
          ],
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children:  [

                  Center(child: Image.asset('assets/images/logo.png')),
                  const SizedBox(height: 20,),

                  const Text('Register', style: TextStyle(fontSize: 48.0, fontWeight: FontWeight.w700),),

                  const SizedBox(height: 30,),

                  InputWidget(icon: Icons.person, hintText: 'UserName', controller: controller.nameController,),
                  const  SizedBox(height: 20,),

                  InputWidget(icon: Icons.email, hintText: 'Email', controller: controller.emailController,),
                  const  SizedBox(height: 20,),
                  InputWidget(icon: Icons.lock, hintText: 'Password',isObscure: true,controller: controller.passwordController,),
                  const  SizedBox(height: 30,),

                  SizedBox(
                      width: 120,
                      child: ButtonWidget(backgroundColor: secondColor, textColor: textWhiteColor, buttonText: 'Register', onPress: (){
                        controller.registerUser(username: controller.nameController.text,
                            email: controller.emailController.text,
                            password: controller.passwordController.text);
                      })
                  ),


                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                     const Text("Already have an account?", ),

                      TextButton(onPressed: (){
                        controller.loginPage();
                      }, child: const Text('Login', style: TextStyle(color: secondColor),))
                    ],
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
