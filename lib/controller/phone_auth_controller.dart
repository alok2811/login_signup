
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:login_signup/helper/constants.dart';

class PhoneAuthController extends GetxController{

  var txtController = TextEditingController();
  var phoneCode = '+91'.obs;

  void sendOTP(String phoneNumber, PhoneCodeSent codeSent,
      PhoneVerificationFailed verificationFailed) {
    if (!phoneNumber.contains('+')) phoneNumber = '+91' + phoneNumber;
    firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 30),
        verificationCompleted: (value){},
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: (value){});

  }


}