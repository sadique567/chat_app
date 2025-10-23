import 'package:chat_app/app/services/database_service.dart';
import 'package:chat_app/app/shared/shared_Pref.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SearchControllerGroup extends GetxController {
  final searchinputController = TextEditingController();
  final isLoading = false.obs;
  final isJoined = false.obs;

  QuerySnapshot? searchSnapShot;
  final hasUserSearched = false.obs;
  final userName = "".obs;
  User? user;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getCurrentUserIdandName();
  }

  getCurrentUserIdandName() async {
    await SharedPref.getUserFullName().then((val) {
      userName.value = val ?? "";
    });

    user = FirebaseAuth.instance.currentUser;
  }

  joinedorNot(
    String userName,
    String groupName,
    String groupId,
    String admin,
  ) async {
    await DatabaseService(userId: user!.uid).isUseJoined(groupName, groupId, userName).then((val){
      isJoined.value = val;

    });
  }
}
