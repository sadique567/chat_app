import 'package:chat_app/app/module/home/home_controller.dart';
import 'package:chat_app/app/routes/app_pages.dart';
import 'package:chat_app/app/services/database_service.dart';
import 'package:chat_app/app/utils/common_widget.dart';
import 'package:chat_app/app/utils/grouptile_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      body: groupList(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          popupDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  groupList(context) {
    return StreamBuilder(
      stream: controller.groups,
      builder: (context, AsyncSnapshot snapshot) {
        // check condition
        if (snapshot.hasData) {
          if (snapshot.data["groups"] != null) {
            if (snapshot.data["groups"].length != 0) {
              return ListView.builder(
                itemCount: snapshot.data["groups"].length,
                itemBuilder: (context, index) {
                  // show most recent group added 
                  int reverseIndex = snapshot.data["groups"].length - index - 1;

                  return GrouptileWidget(
                    userName: snapshot.data["fullname"],
                    groupId: controller.getId(
                      snapshot.data['groups'][reverseIndex],
                    ),
                    groupName: controller.getName(
                      snapshot.data['groups'][reverseIndex],
                    ),
                  );
                },
              );
            } else {
              return noGroupWidget(context);
            }
          } else {
            return noGroupWidget(context);
          }
        } else {
          return Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ),
          );
        }
      },
    );
  }

  void popupDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Create a group", textAlign: TextAlign.center),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(
                () => controller.isLoading == true
                    ? Center(
                        child: CircularProgressIndicator(
                          color: Theme.of(context).primaryColor,
                        ),
                      )
                    : TextField(
                        controller: controller.groupNameController,
                        onChanged: (value) {
                          controller.groupNameController.text = value;
                        },
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Get.back();
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                if (controller.groupNameController.text != "") {
                  controller.isLoading.value = true;
                  DatabaseService(
                        userId: FirebaseAuth.instance.currentUser!.uid,
                      )
                      .createGroup(
                        controller.userName.value,
                        FirebaseAuth.instance.currentUser!.uid,
                        controller.groupNameController.text,
                      )
                      .whenComplete(() {
                        controller.isLoading.value = false;
                      });
                  Get.back();
                  showSnackbar(
                    context,
                    "group Created successfuly",
                    Colors.green,
                  );
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: Text("Create"),
            ),
          ],
        );
      },
    );
  }

  noGroupWidget(context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              popupDialog(context);
            },
            child: Icon(Icons.add_circle, size: 75),
          ),
          SizedBox(height: 10),
          Center(
            child: Text(
              "You have not joined any group. Tap to join group",
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
