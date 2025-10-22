import 'package:chat_app/app/services/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HelpController extends GetxController {
  final RxList<Map<String, dynamic>> messages = <Map<String, dynamic>>[].obs;
  final  textController = TextEditingController();
  final ScrollController scrollController = ScrollController();


FirebaseAuthServices authServices = FirebaseAuthServices();


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
        "isUser": false
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
