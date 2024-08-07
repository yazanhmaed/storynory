import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:storynory/modules/authentication/view/screens/authentication_screen.dart';

import 'home_layout.dart';

class StreamScreen extends StatelessWidget {
  const StreamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            return const HomeLayoutScreen();
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Somthing Went Wrong!'),
            );
          } else {
            return const AuthenticationScreen();
          }
        },
      ),
    );
  }
}
