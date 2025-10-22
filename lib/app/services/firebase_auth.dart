import 'package:chat_app/app/routes/app_pages.dart';
import 'package:chat_app/app/services/database_service.dart';
import 'package:chat_app/app/shared/shared_Pref.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/route_manager.dart';

class FirebaseAuthServices {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // Login Function

  Future loginUser(String email, String password) async {
    try {
      User user = (await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      )).user!;
      if (user != null) {
        return true;
      }
    } on FirebaseException catch (e) {
      print("Login Error $e");
      return e.message;
    }
  }

  // Register Function
  Future registeUserEmailPassword(
    String fullName,
    String email,
    String password,
  ) async {
    try {
      User user = (await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      )).user!;

      if (user != null) {
        // call the databse service to update the userdata

        await DatabaseService(userId: user.uid).savingUserData(fullName, email);
        print("✅ User data saved to Firestore for: ${user.uid}");
        return true;
      }
    } on FirebaseAuthException catch (e) {
      print("Authentication Error $e");
      return e.message;
    }
  }

  // signout Fun
  Future signout() async {
    try {
      await SharedPref.saveUserLogedinStatusSF(false);
      await SharedPref.saveUserEmailSF("");
      await SharedPref.saveUserFullNameSF("");
      await firebaseAuth.signOut();
      Get.offAllNamed(AppRoutes.LOGING_SCREEN);
    } catch (e) {
      print("Signout Error $e");
      return null;
    }
  }
}


/*
reliwell3
reliwell3@gmail.com
Reli@123

*/