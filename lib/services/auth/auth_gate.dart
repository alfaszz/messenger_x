import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messenger_x/services/auth/auth_toggle.dart';
import 'package:messenger_x/pages/home.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: ((context, snapshot) {
            // user is logged in
            if (snapshot.hasData) {
              return Home();
            }

            //user not logged in
            else {
              return const LoginOrRegister();
            }
          })),
    );
  }
}
