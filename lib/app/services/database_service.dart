import 'package:chat_app/app/shared/shared_Pref.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? userId;
  DatabaseService({this.userId});

  //  refrence for our collection
  final CollectionReference userCollection = FirebaseFirestore.instance
      .collection("users");
  final CollectionReference groups = FirebaseFirestore.instance.collection(
    "groups",
  );

  // saving  the user data
  Future savingUserData(String fullName, String email) async {
    await userCollection.doc(userId).set({
      "fullname": fullName,
      "email": email,
      "groups": [],
      "profilepic": "",
      "userId": userId,
    });
  }

  // getting user Data
  // Future gettingUserData(String email) async {
  //   QuerySnapshot snapshot = await userCollection.where("email" , isEqualTo: email).get()
  //   ;
  //   return snapshot;
  // }
  Future<QuerySnapshot> gettingUserData(String email) async {
    return await userCollection.where("email", isEqualTo: email).get();
  }

// get user groups
getUserGroup() async {
  // await SharedPref.getUserEmail();
  return userCollection.doc(userId).snapshots();
}


}
