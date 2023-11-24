import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseInstance {
  factory FirebaseInstance() {
    return _instance;
  }

  FirebaseInstance._internal();
  static final FirebaseInstance _instance = FirebaseInstance._internal();

  FirebaseFirestore get firestore {
    return FirebaseFirestore.instance;
  }

  FirebaseAuth get firebaseAuth {
    return FirebaseAuth.instance;
  }
}
