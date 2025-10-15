
import 'package:chat_app/app/module/help/controller/help_controller.dart';
import 'package:get/get.dart';

class HelpBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put<HelpController>(HelpController());
  }
}
