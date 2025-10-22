import 'package:chat_app/app/module/home/home_controller.dart';
import 'package:chat_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("Group", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(AppRoutes.SEARCH_SCREEN);
            },
            icon: Icon(Icons.search, color: Colors.white),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.all(10),
          children: <Widget>[
            Icon(Icons.account_circle, size: 150, color: Colors.green[200]),
            SizedBox(height: 10),

            Obx(() => Text("Name : ${controller.userName.value}")),
            Obx(() => Text("Email : ${controller.userEmail.value}")),
            Divider(),
            ListTile(
              onTap: () {},
              selectedColor: Theme.of(context).primaryColor,
              selected: true,
              contentPadding: EdgeInsets.symmetric(vertical: 10),
              leading: Icon(Icons.group),
              title: Text("Group"),
            ),
            ListTile(
              onTap: () {
                Get.toNamed(AppRoutes.PROFILE_SCREEN);
              },
              contentPadding: EdgeInsets.symmetric(vertical: 10),
              leading: Icon(Icons.person),
              title: Text("Profile"),
            ),
            Divider(),
            ListTile(
              onTap: () async {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Logout"),
                      content: Text("Are you sure you want to logout?"),
                      actions: [
                        IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: Icon(Icons.cancel, color: Colors.red),
                        ),
                        IconButton(
                          onPressed: () async {
                            await controller.authServices.signout();
                          },
                          icon: Icon(Icons.done, color: Colors.green),
                        ),
                      ],
                    );
                  },
                );
              },
              contentPadding: EdgeInsets.symmetric(vertical: 10),
              leading: Icon(Icons.logout),
              title: Text("Logout"),
            ),
          ],
        ),
      ),
      body: groupList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          popupDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

 groupList() {
  return StreamBuilder(stream: stream, builder: builder);
 }
  
  void popupDialog(BuildContext context) {

  }
}
