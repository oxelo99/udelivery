import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:udelivery/home.dart';
import 'package:udelivery/login_page.dart';

class MainPage extends StatelessWidget{
  const MainPage({super.key});
  @override

  build(context)
  {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const MyApp();
          } else {
            return MediaQuery(data: const MediaQueryData(), child: MyLogin());
          }
        },
    );
  }
}
