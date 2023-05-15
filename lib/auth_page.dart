import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:udelivery/home.dart';
import 'package:udelivery/login_page.dart';
import 'user.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  Future<MyUser> _getUserData(String uid) async {
    MyUser currentUser = MyUser.uid(uid: uid);
    await currentUser.getUserData();
    return currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasData) {
          return FutureBuilder<MyUser>(
            future: _getUserData(snapshot.data!.uid),
            builder: (context, userSnapshot) {
              if (userSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (userSnapshot.hasData) {
                return MyApp(
                  currentUser: userSnapshot.data!,
                );
              } else {
                return const MaterialApp(
                  home: AlertDialog(
                        content: Text(
                            'Eroare la incarcarea datelor utilizatorului'),

                  ),
                );
              }
            },
          );
        } else {
          return const MyLogin();
        }
      },
    );
  }
}
