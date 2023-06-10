import 'package:cloud_firestore/cloud_firestore.dart';

class MyUser {
  String uid='';
  String firstName='';
  String lastName='';
  String phoneNumber='';
  String emailAddress='';

  MyUser();
  MyUser.uid({required this.uid});

  Map<String, dynamic> toMap(){
    return{
      'uid': uid,
      'First Name': firstName,
      'Last Name': lastName,
      'Phone Number': phoneNumber,
      'Email Address': emailAddress,
    };
  }
  Future<void> getUserData() async {
    final userSnapshot =
    await FirebaseFirestore.instance.collection('users').where('Uid', isEqualTo: uid).get();
    final userData = userSnapshot.docs.first.data();
    lastName = userData['Nume'];
    firstName = userData['Prenume'];
    emailAddress = userData['Email'];
    phoneNumber = userData['Phone'];
  }
}
