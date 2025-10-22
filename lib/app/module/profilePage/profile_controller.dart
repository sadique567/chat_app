import 'package:chat_app/app/shared/shared_Pref.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final fullName = "".obs;
  final emailUser = "".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getUserData();
  }

  getUserData() async {
    fullName.value = await SharedPref.getUserEmail() ?? '';
    emailUser.value = await SharedPref.getUserFullName() ?? '';
  }
}
