import 'package:chat_app/app/routes/app_pages.dart';
import 'package:chat_app/app/services/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';

class SignupController extends GetxController {
  RxBool isVisible = true.obs;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final refrellcodeNameController = TextEditingController();
  final fullNameController = TextEditingController();
  final userName = TextEditingController();
  final genderController = TextEditingController();
  final phoneController = TextEditingController();
  final userid = 0.obs;
  final message = "".obs;
  // String url = "$baseUrl$SIGNUP";

  // ApiImport apiImport = ApiImport();

  FirebaseAuthServices authServices = FirebaseAuthServices();

  final otpVerification = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    refrellcodeNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  // void signUp() async {
  //   final response = await http.post(
  //     Uri.parse(url),
  //     headers: {
  //       "Content-Type": "application/json;charset=UTF-8",
  //       "accept": "application/json",
  //     },
  //     body: json.encode({
  //       // "userFullName": refrellcodeNameController.text,
  //       "username": fullNameController.text,
  //       "email": emailController.text,
  //       "phone": phoneController.text,
  //       // "referral": "",
  //       "password": passwordController.text,
  //     }),
  //   );
  //   var data = response.body.toString();
  //   if (response.statusCode == 200) {
  //     refrellcodeNameController.clear();
  //     fullNameController.clear();
  //     userName.clear();
  //     genderController.clear();
  //     emailController.clear();
  //     // ageController.clear();
  //     passwordController.clear();
  //     //    EasyLoading.showToast(data);
  //     Get.snackbar('${response.statusCode == 200}', data);
  //     Get.toNamed(AppRoutes.LOGIN_SCREEN);
  //   } else {
  //     EasyLoading.showToast(data);
  //   }
  // }

  Future<void> signUp() async {
    Map body = {
      "fullname": fullNameController.text,
      "username": userName.text,
      "email": emailController.text,
      "phone": phoneController.text,
      "referral": refrellcodeNameController.text,
      "password": passwordController.text,
    };
    Get.offAllNamed(AppRoutes.LOGING_SCREEN);
  }
}
