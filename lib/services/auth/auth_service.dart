// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messenger_x/models/user.dart';

UserModel? currentUser;

class AuthService {
  //getCurrentUser
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // instance of auth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //instance of firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // sign in
  Future<UserCredential> signInWithEmailPassword(
      String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

           // Get UID of the signed-in user
    String uid = userCredential.user!.uid;

     DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();

        if (userDoc.exists) {
      // Populate UserModel with data from Firestore
      UserModel userModel = UserModel.fromMap(userDoc.data() as Map<String,dynamic>);

      currentUser = userModel;
    } else {
      // Handle the case where user data is not found
      throw Exception('User data not found');
    }

      return userCredential;
    } on FirebaseAuthException catch (e) {
      String errorMessage = '';
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'No user found associated with this email';
          break;
        case 'invalid-credential':
          errorMessage = 'Error occured, Please check entered credential';
          break;
        case 'wrong-password':
          errorMessage = 'Wrong password provided for that user.';
          break;
        case 'invalid-email':
          errorMessage = 'Invalid email address provided.';
          break;
        case 'user-disabled':
          errorMessage = 'User account has been disabled.';
          break;
        default:
          errorMessage = 'An error occurred. Please try again later.';
      }
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Login Error'),
            content: Text(errorMessage),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      throw Exception(e.code);
    }
  }

  //sign up
  Future<UserCredential> signUpWithEmailPassword(
      String email, String password, BuildContext context, String name) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      UserModel newUser =
          UserModel(uid: userCredential.user!.uid, email: email, name: name);

      currentUser = newUser;

      _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .set(newUser.toMap());

      return userCredential;
    } on FirebaseAuthException catch (e) {
      String errorMessage = '';
      switch (e.code) {
        case 'email-already-in-use':
          errorMessage = 'This email already has an account, try logging in';
          break;
        case 'invalid-email':
          errorMessage = "You've entered an invalid email";
          break;
        default:
          errorMessage = 'An error occurred. Please try again later.';
      }
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Login Error'),
            content: Text(errorMessage),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );

      throw Exception(e.code);
    }
  }

  //sign out
  Future<void> signOut() async {
    return await _auth.signOut();
  }

  //errors
}
  