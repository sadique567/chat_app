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

  // update the user data
  Future updateUserData(String fullName, String email) async {
    return await userCollection.doc(userId).set({
      "fullname": fullName,
      "email": email,
      "groups": [],
      "profilepic": "",
      "userId": userId,
    });
  }
}
