
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_signup/controller/phone_auth_controller.dart';
import 'package:login_signup/helper/constants.dart';
import 'package:login_signup/helper/dialog_helper.dart';
import 'package:login_signup/view/verify_view.dart';
import 'package:login_signup/widgets/button_widget.dart';
import 'package:login_signup/widgets/input_widget.dart';

class PhoneAuthView extends StatelessWidget {
  final controller = Get.put(PhoneAuthController());
  PhoneAuthView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        automaticallyImplyLeading: false,
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text("Back", style: TextStyle(color: Colors.black))),
        ],
      ),
      body: Container(
        height: double.infinity,
        padding: const EdgeInsets.all(15),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Image.asset('assets/images/logo.png'),
                const SizedBox( height: 20,),

                const Text('We will send an one time SMS message to verify your phone number.Please enter your number!',),
                const SizedBox( height: 20,),

                CountryCodePicker(
                  onChanged: (code){
                      controller.phoneCode.value = code.toString();
                  },
                  // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                  initialSelection: '+91',
                  // optional. Shows only country name and flag
                  showCountryOnly: false,
                  // optional. Shows only country name and flag when popup is closed.
                  showOnlyCountryWhenClosed: false,
                  // optional. aligns the flag and the Text left
                  alignLeft: true,

                  dialogBackgroundColor: Colors.black54,
                  searchStyle: TextStyle(fontSize: 14, color: Theme.of(context).textTheme.button!.color),
                ),

                InputWidget(keyboardType: TextInputType.phone,icon: Icons.phone_android, controller: controller.txtController, hintText: "Enter Phone Number!"),
                const SizedBox(height: 10,),
                SizedBox(
                  width: 120,
                    child: ButtonWidget(buttonText: 'Send OTP', onPress: () {
                      DialogHelper.hideKeyboard();
                      if(controller.txtController.text.isEmpty){
                        DialogHelper.showSnackBar(strMsg: 'Please enter a valid number!');
                      }else{
                        DialogHelper.showLoading();
                        controller.sendOTP('${controller.phoneCode}${controller.txtController.text.toString()}', (verificationId, forceResendingToken) {
                          Get.off(() => VerifyView(phoneNumber: '${controller.phoneCode}-${controller.txtController.text.toString()}',
                              verificationId: verificationId));
                          DialogHelper.hideLoading();

                        }, (error) {
                          DialogHelper.hideLoading();
                          DialogHelper.showSnackBar(strMsg: error.toString());
                          print(error.toString());

                        });
                      }
                    }, textColor: Colors.black, backgroundColor: primaryColor,

                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
