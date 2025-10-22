import 'package:chat_app/app/module/profilePage/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class ProfileView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("Profile"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.account_circle, size: 150, color: Colors.green[200]),
            SizedBox(height: 10),

            Obx(() => Text("Name : ${controller.fullName.value}")),
            Obx(() => Text("Email : ${controller.emailUser.value}")),
          ],
        ),
      ),
    );
  }
}
