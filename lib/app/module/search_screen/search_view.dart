import 'package:chat_app/app/module/search_screen/search_controller.dart';
import 'package:chat_app/app/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchView extends GetView<SearchControllerGroup> {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text("Search"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          // 🔹 Search Bar
          Container(
            color: Theme.of(context).primaryColor,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Row(
              children: [
                // Search Input
                Expanded(
                  child: TextFormField(
                    controller: controller.searchinputController,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                    decoration: const InputDecoration(
                      hintText: "Search Group...",
                      hintStyle: TextStyle(color: Colors.white70),
                      border: InputBorder.none,
                    ),
                  ),
                ),

                // Search Button
                GestureDetector(
                  onTap: () => initiateSearchMethod(),
                  child: Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: const Icon(Icons.search, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),

          // 🔹 Search Results
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (!controller.hasUserSearched.value) {
                return const Center(
                  child: Text(
                    "Search for groups...",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                );
              }

              if (controller.searchSnapShot == null ||
                  controller.searchSnapShot!.docs.isEmpty) {
                return const Center(
                  child: Text(
                    "No groups found 😕",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                );
              }

              // ✅ Show group list
              return ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                itemCount: controller.searchSnapShot!.docs.length,
                itemBuilder: (context, index) {
                  final data = controller.searchSnapShot!.docs[index];
                  return groupTile(
                    controller.userName.value,
                    data["groupId"],
                    data["groupName"],
                    data["admin"],
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  /// 🔍 Search Logic
  Future<void> initiateSearchMethod() async {
    if (controller.searchinputController.text.isEmpty) return;

    controller.isLoading.value = true;

    await DatabaseService()
        .searchByName(controller.searchinputController.text)
        .then((val) {
          controller.searchSnapShot = val;
          controller.isLoading.value = false;
          controller.hasUserSearched.value = true;
        });
  }

  /// 🧩 Group Tile Widget
  Widget groupTile(
    String userName,
    String groupId,
    String groupName,
    String groupAdmin,
  ) {
    // function to check whether user already Exist
    controller.joinedorNot(userName, groupName, groupId, groupAdmin);

    return ListTile(
      leading: CircleAvatar(
        radius: 30,
        backgroundColor: Colors.amber,
        child: Text(
          groupName.substring(0, 1).toUpperCase(),
          style: TextStyle(color: Colors.white),
        ),
      ),
      title: Text(groupName),
      subtitle: Text(
        "Admin : ${groupAdmin.substring(groupAdmin.indexOf('_') + 1)}",
      ),
      trailing: InkWell(
        onTap: () {},
        child: controller.isJoined.value
            ? Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.black, width: 1),
                ),
                child: Text("Joined"),
              )
            : Container(
                padding: EdgeInsets.all(10),

                decoration: BoxDecoration(color: Colors.blue),
                child: Text("Join now"),
              ),
      ),
    );

    // //  Card(
    //   margin: const EdgeInsets.symmetric(vertical: 6),
    //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    //   elevation: 2,
    //   child: ListTile(
    //     leading: CircleAvatar(
    //       backgroundColor: Theme.of(Get.context!).primaryColor,
    //       child: Text(
    //         groupName.substring(0, 1).toUpperCase(),
    //         style: const TextStyle(
    //           color: Colors.white,
    //           fontWeight: FontWeight.bold,
    //         ),
    //       ),
    //     ),
    //     title: Text(
    //       groupName,
    //       style: const TextStyle(fontWeight: FontWeight.w600),
    //     ),
    //     subtitle: Text("Admin: $groupAdmin"),
    //     trailing: const Icon(Icons.arrow_forward_ios, size: 16),
    //     onTap: () {
    //       Get.snackbar("Joining Group", "You tapped $groupName");
    //     },
    //   ),
    // );
  }
}
