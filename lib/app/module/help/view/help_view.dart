import 'package:chat_app/app/module/help/controller/help_controller.dart';
import 'package:chat_app/app/utils/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class HelpView extends GetView<HelpController> {
  const HelpView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HelpController());

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Help & Support Chat",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: myBackButton(context),
        actions: [
          Row(
            children: [
              GestureDetector(
                onTap: () => EasyLoading.showInfo("Pending"),
                child: Icon(Icons.phone),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.03),

              GestureDetector(
                onTap: () => EasyLoading.showInfo("Pending"),
                child: Icon(Icons.video_call),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.03),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // 🟦 Chat Messages List
          Expanded(
            child: Obx(
              () => ListView.builder(
                controller: controller.scrollController,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                itemCount: controller.messages.length,
                itemBuilder: (context, index) {
                  final msg = controller.messages[index];
                  final isUser = msg["isUser"] as bool;

                  return Align(
                    alignment:
                        isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.75,
                      ),
                      decoration: BoxDecoration(
                        color:
                            isUser
                                ? Colors.teal.shade400
                                : Colors.grey.shade200,

                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(16),
                          topRight: const Radius.circular(16),
                          bottomLeft: Radius.circular(isUser ? 16 : 0),
                          bottomRight: Radius.circular(isUser ? 0 : 16),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 1,
                            offset: const Offset(2, 2),
                          ),
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 1,
                            offset: const Offset(-2, -2),
                          ),
                        ],
                      ),
                      child: Text(
                        msg["text"],
                        style: TextStyle(
                          color: isUser ? Colors.white : Colors.black87,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 7),
            decoration: BoxDecoration(
              // color: Colors.transparent,
              // border: Border.all(color: Theme.of(context).primaryColor),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text Field
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width * 0.02,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(width: 1, color: Colors.black87),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: controller.textController,
                              decoration: InputDecoration(
                                hintText: "Type your message...",
                                // filled: true,
                                fillColor: Colors.transparent,
                                // contentPadding: const EdgeInsets.symmetric(
                                //   horizontal: 14,
                                //   vertical: 10,
                                // ),
                                // border: OutlineInputBorder(
                                //   borderRadius: BorderRadius.circular(15),
                                //   borderSide: BorderSide.none,
                                // ),
                              ),
                            ),
                          ),
                          // Attach File -----------------
                          GestureDetector(
                            onTap: () {
                              EasyLoading.showInfo("Pending");
                            },
                            child: Icon(
                              Icons.attach_file_outlined,
                              color: Colors.deepOrange,
                              size: 24,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.02,
                          ),

                          // Open Camera -----------------
                          GestureDetector(
                            onTap: () {
                              EasyLoading.showInfo("Pending");
                            },
                            child: Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.deepOrange,
                              size: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),

                  // Send Button
                  GestureDetector(
                    onTap: controller.sendMessage,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.teal,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        controller.textController.text.trim().isEmpty
                            ? Icons.mic
                            : Icons.send_rounded,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
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
