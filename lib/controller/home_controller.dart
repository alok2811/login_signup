import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login_signup/helper/constants.dart';
import 'package:login_signup/helper/local_notification.dart';
import 'package:login_signup/view/welcome_view.dart';

class HomeController extends GetxController{
  var title = "".obs;
  var body = "".obs;
  var type = "".obs;


@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    LocalNotificationService.initializer();

    // Terminated State
    FirebaseMessaging.instance.getInitialMessage().then((event) {
      if (event != null) {
        title.value = "${event.notification!.title}";
        body.value = "${event.notification!.body}";
        type.value = "I am coming from terminated state";
      }
    });

    // Foreground State
    FirebaseMessaging.onMessage.listen((event) {
      LocalNotificationService.showNotificationOnForeground(event);
      title.value = "${event.notification!.title}";
      body.value = "${event.notification!.body}";
      type.value = "I am coming from foreground state";
    });

    // background State
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      title.value = "${event.notification!.title}";
      body.value = "${event.notification!.body}";
      type.value = "I am coming from background state";
    });

  }

  //Notification Sending Side Using Dio flutter Library to make http post request

  Future<void> sendNotification(token,title, body)async{
  var postUrl = "https://fcm.googleapis.com/fcm/send";
   final data = {
      "notification": {"body": "$body", "title": "$title"},
      "priority": "high",
      "data": {
        "click_action": "FLUTTER_NOTIFICATION_CLICK",
        "id": "1",
        "status": "done"
      },
      "to": "$token"
    };

    final headers = {
      'content-type': 'application/json',
      'Authorization': 'key=AAAA_u6-9ts:APA91bHp0ofyMx_dcpzUuaOwvjiHJbJrloGDDekBOjslh5r7I_-Qn1a3NVoopMZVmF5-ddNwRkAgGpMbOyFArxbgDXPc0mbRb6dFd7WGF08iXqU0qVB8sTOp2WdIHdNYsAer3flsicQ7'
    };


    BaseOptions options = BaseOptions(
      connectTimeout: 5000,
      receiveTimeout: 3000,
      headers: headers,
    );


    try {
      final response = await Dio(options).post(postUrl,
          data: data);

      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: 'Request Sent To Driver');
      } else {
        print('notification sending failed');
        // on failure do sth
      }
    }
    catch(e){
      print('exception $e');
    }

  }


  void logOutUser() async{
    var provider = firebaseAuth.currentUser!.providerData[0].providerId;
    GoogleSignIn googleSignIn = GoogleSignIn();
    await firebaseAuth.signOut();
    if(provider == 'google.com'){
      await googleSignIn.signOut();
    }else if(provider == 'facebook.com'){
      await FacebookAuth.instance.logOut();
    }
    welcomePage();
  }

  void welcomePage(){
    Get.offAll(()=> WelcomeView());
  }

}