import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ButtonWidget extends StatelessWidget {
  final Color backgroundColor;
  final Color textColor;
  final String buttonText;
  final VoidCallback onPress;

  const ButtonWidget({Key? key,
    required this.backgroundColor,
    required this.textColor,
    required this.buttonText,
    required this.onPress
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      child: Text(buttonText),
      style: ElevatedButton.styleFrom(shape: const StadiumBorder(),
        primary: backgroundColor,
        onPrimary: textColor,
      ),
    );
  }
}
