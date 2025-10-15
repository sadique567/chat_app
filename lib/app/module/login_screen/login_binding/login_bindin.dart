import 'package:chat_app/app/module/login_screen/login_controller/login_controller.dart';
import 'package:get/get.dart';

class LoginBindin extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<LoginController>(() => LoginController(), fenix: true);
    Get.put<LoginController>(LoginController());
  }
}
