import 'package:chat_app/app/routes/app_pages.dart';
import 'package:chat_app/app/shared/shared_Pref.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  late PageController pageController;
  // SharedPreferences prefs = Get.find<SharedPreferences>();
  bool isSignedIn = false;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _moveToNextPage();
    });
    // move to page 1 after 3 seconds
  }

  void _moveToNextPage() async {
    await Future.delayed(const Duration(seconds: 3));
    await checkLogin();
    if (isSignedIn) {
      // ✅ Agar user login hai
      Get.offAllNamed(AppRoutes.CHAT_SCREEN);
    } else {
      // Animate to next page
      pageController.animateToPage(
        1, // page index of LoginScreenProcess
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> checkLogin() async {
    final value = await SharedPref.getUserLoginStatus();
    if (value != null && value == true) {
      isSignedIn = true;
    } else {
      isSignedIn = false;
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    pageController.dispose();
  }
}
