import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  late String name;
  late String price;
  late bool active;
  late String id;

  Product({
    required this.name,
    required this.price,
    required this.active, required String id,
  });
}

class GetProducts {
  final String docID;
  late Product product;

  GetProducts(this.docID) {
    FirebaseFirestore.instance.collection('produse').doc(docID).snapshots().listen((snapshot) {
      product = Product(
        id: snapshot.id,
        name: snapshot['name'],
        price: snapshot['price'],
        active: snapshot['active'],
      );
    });
  }
}