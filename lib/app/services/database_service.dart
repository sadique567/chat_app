import 'package:chat_app/app/shared/shared_Pref.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? userId;
  DatabaseService({this.userId});

  //  refrence for our collection
  final CollectionReference userCollection = FirebaseFirestore.instance
      .collection("users");
  final CollectionReference groupsCollection = FirebaseFirestore.instance
      .collection("groups");

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

  // creating a group
  Future createGroup(String userName, String id, String groupName) async {
    DocumentReference groupDocumentReference = await groupsCollection.add({
      "groupName": groupName,
      "groupIcon": "",
      "admin": "${id}_$userName",
      "members": [],
      "groupId": "",
      "recentMessage": "",
      "recentMessageSender": "",
    });
    // Update the members
    await groupDocumentReference.update({
      "members": FieldValue.arrayUnion(["${userId}_$userName"]),
      "groupId": groupDocumentReference.id,
    });
    DocumentReference userDocumentReference = userCollection.doc(userId);
    return await userDocumentReference.update({
      "groups": FieldValue.arrayUnion([
        "${groupDocumentReference.id}_$groupName",
      ]),
    });
  }

  // getting chats
  getChats(String groupId) async {
    return groupsCollection
        .doc(groupId)
        .collection("Messages")
        .orderBy("time")
        .snapshots();
  }

  Future getGroupAdmin(String groupId) async {
    DocumentReference d = groupsCollection.doc(groupId);
    DocumentSnapshot documentSnapshot = await d.get();
    return documentSnapshot["admin"];
  }
  // get Members

  getGroupMembers(String groupId) async {
    return groupsCollection.doc(groupId).snapshots();
  }

  searchByName(String groupName) {
    return groupsCollection.where("groupName", isEqualTo: groupName).get();
  }

  // Function bool
  Future<bool> isUseJoined(
    String groupName,
    String groupId,
    String userName,
  ) async {
    DocumentReference userDocumentReference = userCollection.doc(userId);
    DocumentSnapshot documentSnapshot = await userDocumentReference.get();

    List<dynamic> groups = await documentSnapshot['groups'];

    if (groups.contains("${groupId}_$groupName")) {
      return true;
    } else {
      return false;
    }
  }

  // toggling the group Join / Exit
  Future toggleGroupJoin(
    String groupId,
    String userName,
    String groupName,
  ) async {
    DocumentReference userDocumentReference = userCollection.doc(userId);
    DocumentReference groupDocumentReference = groupsCollection.doc(
      groupId,
    ); //3:24:43

    DocumentSnapshot documentSnapshot = await userDocumentReference.get();
    List<dynamic> groups = await documentSnapshot['groups'];
    // if user have the Group -> then remove them or also in other part re join them
    if (groups.contains("${groupId}_$groupName")) {
      await userDocumentReference.update({
        "groups": FieldValue.arrayRemove(["${groupId}_$groupName"]),
      });
      await groupDocumentReference.update({
        "members": FieldValue.arrayRemove(["${groupId}_$groupName"]),
      });
    } else {
      await userDocumentReference.update({
        "groups": FieldValue.arrayUnion(["${groupId}_$groupName"]),
      });
      await groupDocumentReference.update({
        "members": FieldValue.arrayUnion(["${groupId}_$groupName"]),
      });
    }
  }
}
