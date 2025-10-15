import 'package:chat_app/app/module/splash_screen/splash_controller/splash_controller.dart';
import 'package:get/get.dart';

class SplashBinding extends Bindings{
  @override
  void dependencies() {
   Get.put<SplashController>(SplashController());
  }
 }