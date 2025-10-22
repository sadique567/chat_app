import 'package:chat_app/app/module/login_screen/login_controller/login_controller.dart';
import 'package:chat_app/app/routes/app_pages.dart';
import 'package:chat_app/app/utils/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class LoginView extends GetView<LoginController> {
  LoginView({super.key});
  final _formKeyUserLogin = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // AppName(),
          SizedBox(height: 15),

          // TypeWriter.text(
          //   "🔒 Login to continue trading securely.",
          //   maintainSize: false,
          //   repeat: true,
          //   textAlign: TextAlign.center,
          //   style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
          //   duration: const Duration(milliseconds: 200),
          // ),
          SizedBox(height: 15),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            margin: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey.withOpacity(0.2),
            ),
            child: Column(
              children: [
                Form(
                  key: _formKeyUserLogin,
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      TextFormField(
                        controller: controller.emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          fillColor: Theme.of(context).scaffoldBackgroundColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          hintText: "Enter Email",
                          prefixIcon: Icon(Icons.email),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Email is Required";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),
                      Obx(
                        () => TextFormField(
                          keyboardType: TextInputType.text,
                          controller: controller.passwordController,
                          obscureText: controller.isVisible.value,

                          decoration: InputDecoration(
                            fillColor: Theme.of(
                              context,
                            ).scaffoldBackgroundColor,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            hintText: "Enter Password",
                            prefixIcon: Icon(Icons.lock_outline),
                            suffixIcon: InkWell(
                              onTap: () {
                                controller.isVisible.value =
                                    !controller.isVisible.value;
                                print(
                                  "visible value ${controller.isVisible.value}",
                                );
                              },
                              child: Icon(
                                controller.isVisible.value
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter Password";
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 15),
                      MyButton(
                        width: Get.width,
                        height: 50,
                        buttonName: "Login",
                        fontSize: 18,
                        textColor: Colors.white,
                        backgroundColor: Colors.blue.withOpacity(1),
                        borderRadius: 15,
                        onTap: () {
                          if (_formKeyUserLogin.currentState!.validate()) {
                            controller.userLogin();
                          }
                        },
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 15),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        EasyLoading.showInfo("work on progress");
                      },
                      child: Text(
                        "Forget Password",
                        style: TextStyle(color: Colors.blue, fontSize: 16),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.offAndToNamed(AppRoutes.SIGNUP_SCREEN);
                      },
                      child: Text(
                        "Don't have an account? SignUp",
                        style: TextStyle(color: Colors.blue, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
