import 'package:chat_app/app/module/profilePage/profile_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/get_instance.dart';

class ProfileBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put<ProfileController>(ProfileController());
  }
}