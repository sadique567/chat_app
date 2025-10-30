import 'package:chat_app/app/model/notification_badge.dart';
import 'package:chat_app/app/model/push_notification_model.dart';
import 'package:chat_app/app/services/database_service.dart';
import 'package:chat_app/app/services/firebase_auth.dart';
import 'package:chat_app/app/shared/shared_Pref.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';

class HomeController extends GetxController {
  FirebaseAuthServices authServices = FirebaseAuthServices();
  final userName = "".obs;
  final userEmail = "".obs;
  Stream? groups;
  final isLoading = false.obs;
  TextEditingController groupNameController = TextEditingController();

  late final FirebaseMessaging messaging;
  late int totalNotificationCounter;
  PushNotificationModel? notificationInfo;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    totalNotificationCounter = 0;
    gettingUserData();

    // Normal Notification
    registerFunction();
    // When App in background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage remoteMessage) {
      PushNotificationModel notificationModel = PushNotificationModel(
        title: remoteMessage.notification!.title,
        body: remoteMessage.notification!.body,
        dataTitle: remoteMessage.data['title'],
        dataBody: remoteMessage.data['body'],
      );
      totalNotificationCounter++;
      notificationInfo = notificationModel;
    });

    // when app in terminated State
    checkForIniialMessage();
  }

  checkForIniialMessage() async {
    await Firebase.initializeApp();

    RemoteMessage? initialMessage = await FirebaseMessaging.instance
        .getInitialMessage();
    if (initialMessage != null) {
      PushNotificationModel notificationModel = PushNotificationModel(
        title: initialMessage.notification!.title,
        body: initialMessage.notification!.body,
        dataTitle: initialMessage.data['title'],
        dataBody: initialMessage.data['body'],
      );
      totalNotificationCounter++;
      notificationInfo = notificationModel;
    }
  }

  String getId(String res) {
    return res.substring(0, res.indexOf("_"));
  }

  String getName(String res) {
    return res.substring(res.indexOf("_") + 1);
  }

  gettingUserData() async {
    userName.value = await SharedPref.getUserEmail().toString();
    userEmail.value = await SharedPref.getUserFullName().toString();

    await DatabaseService(
      userId: FirebaseAuth.instance.currentUser!.uid,
    ).getUserGroup().then((snapshot) {
      groups = snapshot;
    });
  }

  // register Notification
  void registerFunction() async {
    await Firebase.initializeApp();
    messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("user granted the permission");
      // main massage send from here
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        PushNotificationModel notificationModel = PushNotificationModel(
          title: message.notification!.title,
          body: message.notification!.body,
          dataTitle: message.data['title'],
          dataBody: message.data['body'],
        );
        totalNotificationCounter++;
        notificationInfo = notificationModel;

        if (notificationModel != null) {
          showSimpleNotification(
            Text(notificationInfo!.title!),
            leading: NotificationBadge(
              totalNotificat: totalNotificationCounter,
            ),
            subtitle: Text(notificationInfo!.body!),
            background: Colors.cyan,
            duration: Duration(seconds: 3),
          );
        }
      });
    } else {
      print("Permission Declned by user");
    }
  }
}
