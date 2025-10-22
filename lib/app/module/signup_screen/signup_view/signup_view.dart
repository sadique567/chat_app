import 'package:chat_app/app/module/signup_screen/signup_controller/signup_controller.dart';
import 'package:chat_app/app/routes/app_pages.dart';
import 'package:chat_app/app/utils/button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class SignupView extends GetView<SignupController> {
  final _formKeySignUp = GlobalKey<FormState>();

  SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 1, vertical: 50),
        children: [
          // Center(child: AppName()),
          SizedBox(height: 25),
          Form(
            key: _formKeySignUp,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              margin: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey.withOpacity(0.2),
              ),
              child: Column(
                children: [
                  // TextFormField(
                  //   controller: controller.refrellcodeNameController,
                  //   keyboardType: TextInputType.name,
                  //   decoration: InputDecoration(
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(12),
                  //     ),
                  //     hintText: "Reffere code",
                  //     label: Text("Reffere code"),
                  //     prefixIcon: Icon(CupertinoIcons.gift),
                  //   ),
                  //   // validator: (value) {
                  //   //   if (value == null || value.isEmpty) {
                  //   //     return "First name is required";
                  //   //   }
                  //   //   return null;
                  //   // },
                  // ),
                  // SizedBox(height: 10),
                  TextFormField(
                    controller: controller.fullNameController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: "Enter your Full Name",
                      label: Text("Enter your Full name"),
                      prefixIcon: Icon(Icons.person),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Full name is required";
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 10),
                  // TextFormField(
                  //   controller: controller.userName,
                  //   keyboardType: TextInputType.name,
                  //   decoration: InputDecoration(
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(12),
                  //     ),
                  //     hintText: "User Name",
                  //     label: Text("User Name"),
                  //     prefixIcon: Icon(CupertinoIcons.person),
                  //   ),
                  //   validator: (value) {
                  //     if (value == null || value.isEmpty) {
                  //       return "User Name is required";
                  //     }
                  //     return null;
                  //   },
                  // ),

                  // SizedBox(height: 10),

                  // TextFormField(
                  //   controller: controller.phoneController,
                  //   keyboardType: TextInputType.number,
                  //   decoration: InputDecoration(
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(12),
                  //     ),
                  //     hintText: "Phone",
                  //     label: Text("Phone Number"),
                  //     prefixIcon: Icon(Icons.phone),
                  //   ),
                  //   validator: (value) {
                  //     if (value == null || value.isEmpty) {
                  //       return "Phone is Required";
                  //     }
                  //     return null;
                  //   },
                  // ),
                  // SizedBox(height: 10),
                  TextFormField(
                    controller: controller.emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: "Enter Email",
                      label: Text("Enter Email"),
                      prefixIcon: Icon(Icons.email),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Email is Required";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  Obx(
                    () => TextFormField(
                      keyboardType: TextInputType.text,
                      controller: controller.passwordController,
                      obscureText: controller.isVisible.value,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: "Enter Password",
                        label: Text("Enter Password"),
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
                    buttonName: "Register",
                    fontSize: 18,
                    textColor: Colors.white,
                    backgroundColor: Colors.blue.withOpacity(0.5),
                    borderRadius: 15,
                    onTap: () {
                      if (_formKeySignUp.currentState!.validate()) {
                        controller.signUp();
                        // controller.sendOtp();
                      }
                    },
                  ),
                  SizedBox(height: 15),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.offAndToNamed(AppRoutes.LOGING_SCREEN);
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(color: Colors.blue, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
