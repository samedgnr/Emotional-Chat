import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../bottomnav_bar.dart';
import 'auth_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return NavBar(
              finalindex: 0,
            );
          } else {
            return const AuthPage();
          }
        },
      ),
    );
  }
}
