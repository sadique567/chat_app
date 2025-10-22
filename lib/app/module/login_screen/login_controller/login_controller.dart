import 'package:chat_app/app/routes/app_pages.dart';
import 'package:chat_app/app/services/database_service.dart';
import 'package:chat_app/app/services/firebase_auth.dart';
import 'package:chat_app/app/shared/shared_Pref.dart';
import 'package:chat_app/app/utils/common_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController
    with GetSingleTickerProviderStateMixin {
  // SharedPreferences prefs = Get.find<SharedPreferences>();

  RxBool isVisible = true.obs;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  // final userid = 0.obs;
  final message = "".obs;
  final islogin = false.obs;
  late TabController tabController;

  FirebaseAuthServices authServices = FirebaseAuthServices();

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
  }

  Future<void> userLogin(BuildContext context) async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    final value = await authServices.loginUser(email, password);

    if (value == true) {
      QuerySnapshot snapshot = await DatabaseService(
        userId: FirebaseAuth.instance.currentUser!.uid,
      ).gettingUserData(email);

      if (snapshot.docs.isNotEmpty) {
        await SharedPref.saveUserLogedinStatusSF(true);
        await SharedPref.saveUserEmailSF(email);
        await SharedPref.saveUserFullNameSF(snapshot.docs[0]["fullname"]);
        Get.toNamed(AppRoutes.HOME_SCREEN);
      } else {
        showSnackbar(context, "User data not found", Colors.red);
      }
    } else {
      showSnackbar(context, value, Colors.red);
    }
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}

//Reli@123
