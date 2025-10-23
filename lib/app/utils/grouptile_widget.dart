import 'package:chat_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class GrouptileWidget extends StatefulWidget {
  final String userName;
  final String groupId;
  final String groupName;

  GrouptileWidget({
    Key? key,
    required this.userName,
    required this.groupId,
    required this.groupName,
  }) : super(key: key);

  @override
  State<GrouptileWidget> createState() => _GrouptileWidgetState();
}

class _GrouptileWidgetState extends State<GrouptileWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          AppRoutes.CHAT_SCREEN,
          arguments: {
            "userName": widget.userName,
            "groupId": widget.groupId,
            "groupName": widget.groupName,
          },
        );
      },
      child: Container(
        padding: EdgeInsets.all(10),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: Theme.of(context).primaryColor,
            child: Text(
              widget.groupName.substring(0, 1).toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          title: Text(
            widget.groupName,
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          subtitle: Text(
            "Join the Conversation as ${widget.userName}",
            style: TextStyle(fontSize: 13),
          ),
        ),
      ),
    );
  }
}
/*
Reliwell Technologies

*/