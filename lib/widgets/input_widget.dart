import 'package:flutter/material.dart';
import 'package:login_signup/helper/constants.dart';

class InputWidget extends StatelessWidget {

  final IconData icon;
  final TextEditingController controller;
  final Color iconColor;
  final TextInputType keyboardType;
  final String hintText;
  final bool isObscure;

  const InputWidget({Key? key,
    required this.icon,
    required this.controller,
    this.isObscure = false,
    this.keyboardType = TextInputType.text,
    this.iconColor = secondColor,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: true,
      controller: controller,
      keyboardType: keyboardType,
      cursorColor: iconColor,
      obscureText: isObscure,
      decoration: InputDecoration(
       prefixIcon:  Icon(
         icon,
         color: iconColor,
       ),
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2.5)
        )
      ),
    );
  }
}
