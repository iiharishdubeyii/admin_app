import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gc_admin_app/login.dart';
import 'package:gc_admin_app/main.dart';

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final User? user = snapshot.data;
          if (user == null) {
            return PhoneAuthScreen();
          } else {
            return HomePage();
          }
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
