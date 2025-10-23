import 'package:chat_app/app/services/database_service.dart';
import 'package:chat_app/app/services/firebase_auth.dart';
import 'package:chat_app/app/shared/shared_Pref.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  FirebaseAuthServices authServices = FirebaseAuthServices();
  final userName = "".obs;
  final userEmail = "".obs;
  Stream? groups;
  final isLoading = false.obs;
  TextEditingController groupNameController = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    gettingUserData();
  }

String getId(String res){
  return res.substring(0 , res.indexOf("_"));
}


String getName(String res){
  return res.substring(res.indexOf("_")+1);
}

  gettingUserData() async {
    userName.value = await SharedPref.getUserEmail() ?? '';
    userEmail.value = await SharedPref.getUserFullName() ?? '';
    await DatabaseService(
      userId: FirebaseAuth.instance.currentUser!.uid,
    ).getUserGroup().then((snapshot) {
      groups = snapshot;
    });
  }
}
