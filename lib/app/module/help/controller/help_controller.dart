import 'package:chat_app/app/services/database_service.dart';
import 'package:chat_app/app/services/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HelpController extends GetxController {
  final RxList<Map<String, dynamic>> messages = <Map<String, dynamic>>[].obs;
  final textController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  final RxString groupId = ''.obs;
  final RxString groupName = ''.obs;
  final RxString userName = ''.obs;

  FirebaseAuthServices authServices = FirebaseAuthServices();

  String admin = "";
  Stream<QueryDocumentSnapshot>? chats;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>;
    groupId.value = args["groupId"] ?? '';
    groupName.value = args["groupName"] ?? '';
    userName.value = args["userName"] ?? '';
    print("✅ groupId: ${groupId.value}");
    print("✅ groupName: ${groupName.value}");
    print("✅ userName: ${userName.value}");
  }

  getChatAndAdmin() {
    DatabaseService().getChats(groupId.value).then((val) {
      chats = val;
    });
    DatabaseService().getGroupAdmin(groupId.value).then((val) {
      admin = val;
    });
  }

  void sendMessage() {
    final text = textController.text.trim();
    if (text.isEmpty) return;

    // Add user message
    messages.add({"text": text, "isUser": true});
    textController.clear();

    // Simulate a bot reply
    Future.delayed(const Duration(milliseconds: 600), () {
      messages.add({
        "text": "Support: Thanks for reaching out! How can I assist you?",
        "isUser": false,
      });
      scrollToBottom();
    });

    scrollToBottom();
  }

  void scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }
}
