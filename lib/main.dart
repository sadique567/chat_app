import 'package:chat_app/app/routes/app_pages.dart';
import 'package:chat_app/app/shared/constant_data.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: ConstantData.apiKey,
        appId: ConstantData.appId,
        messagingSenderId: ConstantData.messagingSenderId,
        projectId: ConstantData.projectId,
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: AppPages.INITIAL_SCREEN,
      getPages: AppPages.myRoutes,
      builder: EasyLoading.init(),
    );
  }
}



/*

mohd sadique
mohdsadique1@gmail.com
Reli@12345

*/