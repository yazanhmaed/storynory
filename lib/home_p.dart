import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'layout/home_layout.dart';
import 'modules/login_screen/login_screen.dart';

class Homep extends StatelessWidget {
  const Homep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.connectionState== ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(),);
          }
         else if(snapshot.hasData){
            return const HomeLayoutScreen();
          }
         else if(snapshot.hasError){
            return const Center(child: Text('Somthing Went Wrong!'),);
          }

         else {
            return const LoginScreen();
          }
        },
      ),
    );
  }
}
