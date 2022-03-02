import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final CollectionReference users =
    FirebaseFirestore.instance.collection('Users');

final firestoreInstance = FirebaseFirestore.instance;

Future<void> userSetup(
    String displayName, String email, String phoneNum) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser.uid.toString();
  users.doc(uid).set({
    'displayName': displayName,
    'email': email,
    'phoneNum': phoneNum,
  });
  return;
}
