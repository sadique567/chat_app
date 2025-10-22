import 'package:chat_app/app/services/firebase_auth.dart';
import 'package:chat_app/app/shared/shared_Pref.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  FirebaseAuthServices authServices = FirebaseAuthServices();
  final userName = "".obs;
  final userEmail = "".obs;
  Stream ? groups;
  

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    gettingUserData();
  }

  gettingUserData() async {
    userName.value = await SharedPref.getUserEmail() ?? '';
    userEmail.value = await SharedPref.getUserFullName() ?? '';
  }
}
