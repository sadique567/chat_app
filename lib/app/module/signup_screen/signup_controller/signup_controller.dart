import 'package:chat_app/app/routes/app_pages.dart';
import 'package:chat_app/app/services/firebase_auth.dart';
import 'package:chat_app/app/shared/shared_Pref.dart';
import 'package:chat_app/app/utils/common_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  Future<void> signUp(context) async {
    Map body = {
      "fullname": fullNameController.text,
      "username": userName.text,
      "email": emailController.text,
      "phone": phoneController.text,
      "referral": refrellcodeNameController.text,
      "password": passwordController.text,
    };

    await authServices
        .registeUserEmailPassword(
          fullNameController.text,
          emailController.text,
          passwordController.text,
        )
        .then((value) async {
          if (value == true) {
            // saving sharedpreference state
            await SharedPref.saveUserLogedinStatusSF(value);
            await SharedPref.saveUserEmailSF(emailController.text);
            await SharedPref.saveUserFullNameSF(fullNameController.text);
            Get.offAllNamed(AppRoutes.LOGING_SCREEN);

            print("value $value");
          } else {
            showSnackbar(context, value, Colors.red);
          }
        });
  }
}


/*
khan1
khan1@gmail.com
Reli@123



*/