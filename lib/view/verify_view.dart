import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_signup/controller/verify_controller.dart';
import 'package:login_signup/helper/constants.dart';
import 'package:login_signup/helper/dialog_helper.dart';
import 'package:login_signup/widgets/button_widget.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyView extends StatelessWidget {
  final String phoneNumber;
  final String verificationId;
  VerifyView({Key? key, required this.phoneNumber,required this.verificationId}) : super(key: key);
  final controller = Get.put(VerifyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Image.asset('assets/images/logo.png'),
                const SizedBox( height: 20,),

                Text('One Time Password (OTP) has been sent to your mobile $phoneNumber, please enter OTP here to verify your mobile.',),
                const SizedBox( height: 20,),

                PinCodeTextField(
                  autoFocus: true,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    fieldWidth: 40,
                    inactiveColor: Colors.grey,
                    selectedColor: Theme.of(context).primaryColor,
                    activeColor: Theme.of(context).primaryColor,
                    selectedFillColor: Theme.of(context).textTheme.button!.color
                  ),
                  textStyle: TextStyle(color: Theme.of(context).textTheme.button!.color),
                  length: 6,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  keyboardType: TextInputType.number,
                  animationDuration: const Duration(milliseconds: 300),
                  onCompleted: (value) {
                    DialogHelper.showLoading();
                     DialogHelper.hideKeyboard();
                    controller.smsCode.value = value.toString();
                    controller.submitOTP(verificationId: verificationId, smsCode: controller.smsCode.value,phoneNumber: phoneNumber);
                  },
                  onChanged: (value) {
                      controller.smsCode.value = value.toString();

                  }, appContext: context,
                ),
                const SizedBox(height: 10,),
                SizedBox(
                  width: 120,
                  child: ButtonWidget(textColor: Colors.black, backgroundColor: primaryColor, buttonText: "Submit", onPress: (){
                    controller.submitOTP(verificationId: verificationId, smsCode: controller.smsCode.value, phoneNumber: phoneNumber);
                  },)
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
