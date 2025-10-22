import 'package:chat_app/app/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthServices {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // Login Function

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

        DatabaseService(userId: user.uid);
        
        return true;
      }
    } on FirebaseAuthException catch (e) {
      print("Authentication Error $e");
    }
  }

  // signout Fun
}
