import 'package:chat_app/app/routes/app_pages.dart';
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

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
  }

  Future<void> userLogin() async {
    Map body = {
      "email": emailController.text,
      "password": passwordController.text,
    };
    Get.toNamed(AppRoutes.CHAT_SCREEN);
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
