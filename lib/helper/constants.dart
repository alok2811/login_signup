import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

const Color primaryColor = Color(0xffffe734);
const Color secondColor = Color(0xffed473c);
const Color textBlackColor = Colors.black;
const Color textWhiteColor = Colors.white;


const Color facebookColor = Color(0xff39579A);
const Color twitterColor = Color(0xff00ABEA);
const Color instaColor = Color(0xffBE2289);
const Color whatsappColor = Color(0xff075E54);
const Color linkedinColor = Color(0xff0085E0);
const Color githubColor = Color(0xff202020);
const Color googleColor = Color(0xffDF4A32);


// FIREBASE
var firebaseAuth = FirebaseAuth.instance;
var firebaseStorage = FirebaseStorage.instance;
var fireStore = FirebaseFirestore.instance;

const MaterialColor primaryMaterialColor = MaterialColor(
  4294960948,
  <int, Color>{
    50: Color.fromRGBO(
      255,
      231,
      52,
      .1,
    ),
    100: Color.fromRGBO(
      255,
      231,
      52,
      .2,
    ),
    200: Color.fromRGBO(
      255,
      231,
      52,
      .3,
    ),
    300: Color.fromRGBO(
      255,
      231,
      52,
      .4,
    ),
    400: Color.fromRGBO(
      255,
      231,
      52,
      .5,
    ),
    500: Color.fromRGBO(
      255,
      231,
      52,
      .6,
    ),
    600: Color.fromRGBO(
      255,
      231,
      52,
      .7,
    ),
    700: Color.fromRGBO(
      255,
      231,
      52,
      .8,
    ),
    800: Color.fromRGBO(
      255,
      231,
      52,
      .9,
    ),
    900: Color.fromRGBO(
      255,
      231,
      52,
      1,
    ),
  },
);


