import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;

  const RegisterPage({Key? key, required this.showLoginPage}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  final _confirmpasswordcontroller = TextEditingController();
  final _numecontroller = TextEditingController();
  final _prenumecontroller = TextEditingController();
  final _phonecontroller = TextEditingController();
  String _errorMessage = '';

  //Verificare date introduse de utilizator
  bool passwordCheck() {
    if (_passwordcontroller.text.trim() ==
        _confirmpasswordcontroller.text.trim()) {
      return true;
    } else {
      setState(() {
        _errorMessage = 'Parolele nu corespund!';
      });
      return false;
    }
  }

  bool dataCheck() {
    if (_numecontroller.text.trim().isEmpty ||
        _prenumecontroller.text.trim().isEmpty ||
        _phonecontroller.text.trim().isEmpty ||
        _emailcontroller.text.trim().isEmpty ||
        _passwordcontroller.text.trim().isEmpty ||
        _confirmpasswordcontroller.text.trim().isEmpty) {
      setState(() {
        _errorMessage = 'Toate campurile sunt obligatorii!';
      });
      return false;
    } else {
      return true;
    }
  }

  Future signUp() async {
    if (passwordCheck() == true && dataCheck() == true) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailcontroller.text.trim(),
          password: _passwordcontroller.text.trim());
    }

    //add user data
    addUserDetails(_numecontroller.text.trim(), _prenumecontroller.text.trim(),
        _phonecontroller.text.trim(), _emailcontroller.text.trim());
  }

  Future addUserDetails(
      String nume, String prenume, String phone, String email) async {
    await FirebaseFirestore.instance.collection('users').add({
      'Nume': nume,
      'Prenume': prenume,
      'Phone': phone,
      'Email': email,
    });
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
                const Text('Creare Cont Nou',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    )),
                const SizedBox(
                  height: 50,
                ),
                const Text('Completeaza datele de mai jos:',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    )),
                const SizedBox(
                  height: 10,
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
                        controller: _numecontroller,
                        decoration: const InputDecoration(
                          hintText: 'Nume',
                        ),
                      )),
                ),
                const SizedBox(
                  height: 10,
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
                        controller: _prenumecontroller,
                        decoration: const InputDecoration(
                          hintText: 'Prenume',
                        ),
                      )),
                ),
                const SizedBox(
                  height: 10,
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
                        controller: _phonecontroller,
                        decoration: const InputDecoration(
                          hintText: 'Numar de telefon',
                        ),
                      )),
                ),
                const SizedBox(
                  height: 10,
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
                        controller: _emailcontroller,
                        decoration: const InputDecoration(
                          hintText: 'Email',
                        ),
                      )),
                ),
                const SizedBox(
                  height: 10,
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
                          hintText: 'Parola',
                        ),
                      )),
                ),
                const SizedBox(
                  height: 10,
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
                        controller: _confirmpasswordcontroller,
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: 'Repeta Parola',
                        ),
                      )),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  _errorMessage,
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: GestureDetector(
                    onTap: signUp,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                          child: Text(
                        'Inregistrare',
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
                GestureDetector(
                  onTap: widget.showLoginPage,
                  child: const Text('Ai deja cont? Conecteaza-te acum',
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
