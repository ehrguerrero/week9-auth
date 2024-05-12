import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseUsersAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getAllUsers() {
    return db.collection("users").snapshots();
  }
}
