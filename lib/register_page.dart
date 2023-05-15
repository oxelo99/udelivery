import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:udelivery/login_page.dart';
import 'package:udelivery/theme_data.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

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
  String uid='';
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
      if (passwordCheck() == true) {
        return true;
      } else {
        return false;
      }
    }
  }

  Future signUp() async {
    if (dataCheck() == true) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailcontroller.text.trim(),
            password: _passwordcontroller.text.trim());
        uid = FirebaseAuth.instance.currentUser!.uid;
        await addUserDetails(
          _numecontroller.text.trim(),
          _prenumecontroller.text.trim(),
          _phonecontroller.text.trim(),
          _emailcontroller.text.trim(),
          uid,
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-email') {
          setState(() {
            _errorMessage = 'Adresa de mail este invalida!';
          });
        } else if (e.code == 'email-already-in-use') {
          setState(() {
            _errorMessage='Exista un cont cu aceasta adresa de email!';
          });}else if (e.code == 'weak-password') {
          setState(() {
            _errorMessage='Parola trebuie sa aibe cel putin 6 caractere!';
          });}
      }
    }
  }

  Future addUserDetails(
      String nume, String prenume, String phone, String email, String uid) async {
    await FirebaseFirestore.instance.collection('users').add({
      'Nume': nume,
      'Prenume': prenume,
      'Phone': phone,
      'Email': email,
      'Uid': uid,
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: MyTheme.lightTheme,
      darkTheme: MyTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              //Coloana principala care este un vector de widgeturi si contine tot ecranul
              children: [
                const SizedBox(
                  //formeaza un mic spatiu pe orizontala intre widgeturi
                  height: 50,
                ),
                Text('Creare Cont Nou', //titlu
                    style: TextStyle(
                      color: MyTheme.textColor(context),
                      fontSize: 25,
                    )),
                const SizedBox(
                  height: 50,
                ),
                Text('Completeaza datele de mai jos:', //info
                    style: TextStyle(
                      color: MyTheme.textColor(context),
                      fontSize: 15,
                    )),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  //camp nume
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  //se creaza o margine interioara astfel incat field-ul sa dea impresia
                  child: TextField(
                    //unei margini si sa nu ocupe toata latimea coloanei(ecranului)
                    controller: _numecontroller,
                    decoration: const InputDecoration(
                      labelText: 'Nume',
                    ),
                    style: TextStyle(
                      color: MyTheme.textColor(context),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: TextField(
                      //camp prenume
                      controller: _prenumecontroller,
                      decoration: const InputDecoration(
                        labelText: 'Prenume',
                      ),
                      style: TextStyle(
                        color: MyTheme.textColor(context),
                      ),
                    )),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  //camp numar tel
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: TextField(
                    controller: _phonecontroller,
                    decoration: const InputDecoration(
                      labelText: 'Numar de telefon',
                    ),
                    style: TextStyle(
                      color: MyTheme.textColor(context),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  //camp email
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: TextField(
                    controller: _emailcontroller,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                    ),
                    style: TextStyle(
                      color: MyTheme.textColor(context),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  //camp parola
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: TextField(
                    controller: _passwordcontroller,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Parola',
                    ),
                    style: TextStyle(
                      color: MyTheme.textColor(context),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  //camp confirmare parola
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: TextField(
                    controller: _confirmpasswordcontroller,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Repeta Parola',
                    ),
                    style: TextStyle(
                      color: MyTheme.textColor(context),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  //furnizeaza utilizatorului posibilele erori pe care le
                  _errorMessage, //putea produce la completarea informatiilor
                  style: TextStyle(color: MyTheme.textColor(context)),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  //Buton inregistrare
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: GestureDetector(
                    onTap: signUp,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      decoration: BoxDecoration(
                        color: MyTheme.buttonColor(context),
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
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MyLogin(),
                        ));
                  },
                  child: Text('Ai deja cont? Conecteaza-te acum',
                      style: TextStyle(color: MyTheme.textColor(context))),
                ),
                const SizedBox(height: 30),
                Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
