import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_model.dart';

class AuthService {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<String> registerUser(
      {required String email,
        required String userName,
        required String password}) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty && userName.isNotEmpty) {
        UserCredential userCredential =
        await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        UserModel userModel = UserModel(
          uid: userCredential.user!.uid,
          email: email,
          userName: userName,
        );
        await firebaseFirestore
            .collection('users')
            .doc(userCredential.user!.uid)
            .set(userModel.toJson());
        return 'success';
      } else {
        return 'Please fill all the fields';
      }
    } catch (err) {
      return 'Error Occurred';
    }
  }

  Future<String> loginUser(
      {required String email, required String password}) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return 'success';
    } catch (err) {
      return 'Error Occurred';
    }
  }

  Future signOut() async {
    await firebaseAuth.signOut();
  }
}
