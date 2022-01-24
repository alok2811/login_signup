import 'dart:ffi';

import 'package:flutter/material.dart';

class SocialButtonsRect extends StatelessWidget {
 final String title;
 final Color color;
 final IconData icon;
 final VoidCallback onTap;
  const SocialButtonsRect({Key? key,
    required this.title,
    required this.color,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        decoration: BoxDecoration(
            color: color, borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              color: Colors.white,
            ),
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: Text(title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400)),
            ),
          ],
        ),
      ),
    );
  }
}

class SocialButtonCircle extends StatelessWidget {

  final Color color;
  final IconData icon;
  final double size;
  final Color iconColor;
  final VoidCallback onTap;
  const SocialButtonCircle({Key? key,
    required this.color,
    required this.icon,
    this.size = 24,
    this.iconColor = Colors.white,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onTap, child: Icon(icon,size: size,), style: ElevatedButton.styleFrom(
      shape: const CircleBorder(),
      primary: color,
      padding: const EdgeInsets.all(16),
    ),);
  }
}

