import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();

  Future signIn() async{
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailcontroller.text.trim(), password: _passwordcontroller.text.trim());
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Material(
        color: Colors.black38,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.center,
              //mainAxisAlignment: MainAxisAlignment.center,

              children: [
                const SizedBox(
                  height: 50,
                ),
                Image.asset('assets/UnitLogo.png'),
                const SizedBox(
                  height: 25,
                ),
                const Text('uDelivery',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    )),
                const SizedBox(
                  height: 5,
                ),
                const Text('Bine ai revenit!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    )),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: _emailcontroller,
                        decoration: const InputDecoration(
                          hintText: 'Email',
                        ),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: _passwordcontroller,
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: 'Password',
                        ),
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: GestureDetector(
                    onTap: signIn,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      decoration: BoxDecoration(color: Colors.orange,
                      borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                          child: Text(
                        'Log In',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      )),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                const Text('Creaza un cont nou', style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
