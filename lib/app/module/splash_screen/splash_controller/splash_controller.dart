import 'package:chat_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  late PageController pageController;
  // SharedPreferences prefs = Get.find<SharedPreferences>();

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _moveToNextPage();
    });
    // move to page 1 after 3 seconds
    // checkLogin();
  }

  void _moveToNextPage() async {
    await Future.delayed(const Duration(seconds: 3));

    // Animate to next page
    pageController.animateToPage(
      1, // page index of LoginScreenProcess
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void checkLogin() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.offAllNamed(AppRoutes.CHAT_SCREEN);
    });
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    pageController.dispose();
  }
}
