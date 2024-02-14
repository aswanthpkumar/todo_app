import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todoapp/models/user_model.dart';

// add

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('users');

  Future<UserCredential?> registerUser(UserModel user) async {
    UserCredential userData = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: user.email.toString(), password: user.password.toString());

    if (userData != null) {
      FirebaseFirestore.instance
          .collection('user')
          .doc(userData.user!.uid)
          .set({
        'uid': userData.user!.uid,
        'email': userData.user!.email,
        'name': user.name,
        'createdAt': user.createdAt,
        'status': user.status,
      });
    }
    return userData;
  }

  // login

  Future<DocumentSnapshot?> loginUser(UserModel user) async {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
      email: user.email.toString(),
      password: user.password.toString(),
    );
  }

  // save the data to sharedpreference
}
