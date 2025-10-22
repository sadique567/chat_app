import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

Widget appBg({Widget? child}) {
  return Scaffold(
    body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage("asset/image/logo.png")),
      ),
      child: child,
    ),
  );
}

Widget myHeadingText({String? text}) {
  return Text(
    text ?? "",
    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
  );
}

Widget myBackButton(BuildContext context) {
  return InkWell(
    onTap: () => Get.back(),
    child: Icon(Icons.arrow_back_ios_new),
  );
}

void showSnackbar(BuildContext context, message, Color) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message??''),
      backgroundColor: Color,
      duration: Duration(seconds: 2),
      action: SnackBarAction(
        label: "Ok",
        onPressed: () {},
        textColor: Colors.white,
      ),
    ),
  );
}
