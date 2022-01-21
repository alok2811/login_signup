import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:login_signup/controller/welcome_controller.dart';
import 'package:login_signup/helper/constants.dart';
import 'package:login_signup/view/phone_auth_view.dart';
import 'package:login_signup/widgets/button_widget.dart';
import 'package:login_signup/widgets/social_button.dart';

class WelcomeView extends StatelessWidget {
  WelcomeView({Key? key}) : super(key: key);
  final controller = Get.put(WelcomeController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: double.infinity,
          width: double.infinity,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [

                  Center(child: Image.asset('assets/images/logo.png')),
                const SizedBox(height: 20,),
              
                const Text('Welcome', style: TextStyle(fontSize: 48.0, fontWeight: FontWeight.w700),),

                const SizedBox(height: 30,),

                  Text('Growing your business is easier then you think!', style:GoogleFonts.oswald(textStyle: const TextStyle(fontSize: 30.0, fontWeight: FontWeight.w400)) ,textAlign: TextAlign.center,),

                  const SizedBox(height: 30,),

                 Row(
                   children: [
                     Expanded(child: ButtonWidget(backgroundColor: const Color(0xffffe734), textColor: Colors.black, onPress: ()=> controller.loginPage(), buttonText: 'Login',)),
                    const SizedBox(width: 10,),
                     Expanded(child: ButtonWidget(backgroundColor: Colors.redAccent, textColor: Colors.white, onPress: () => controller.registerPage(), buttonText: 'Register',)),
                   ]

                 ),

                  Row(
                    children:  const [
                      Expanded(
                        child: Divider(color: secondColor,thickness: 2.5,),
                      ),

                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('LOGIN WITH', style:  TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                        ),
                      ),

                      Expanded(
                        child: Divider(color: secondColor, thickness: 2.5,),
                      ),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SocialButtonCircle(color: googleColor, icon: FontAwesomeIcons.google, onTap: () {
                        controller.googleSignIn();
                      },),
                      SocialButtonCircle(color: facebookColor, icon: FontAwesomeIcons.facebook, onTap: () { },size: 30,),
                      SocialButtonCircle(color: whatsappColor, icon: Icons.phone_android, onTap: () {
                        Get.to(() => PhoneAuthView());
                      },),
                    ],
                  ),
                 const SizedBox(height: 20,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
