import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:udelivery/Home.dart';
import 'package:udelivery/login_page.dart';

import 'auth_page.dart';

class MainPage extends StatelessWidget{
  const MainPage({super.key});
  @override

  build(context)
  {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return MyApp();
          } else {
            return const AuthPage();
          }
        },
    );
  }
}
