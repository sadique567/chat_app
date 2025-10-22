import 'package:chat_app/app/module/home/home_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/get_instance.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HomeController>(HomeController());
  }
}
