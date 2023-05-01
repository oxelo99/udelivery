import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'productWidget.dart';
import 'product.dart';

class MemoMenu extends StatefulWidget {
  const MemoMenu({Key? key}) : super(key: key);

  @override
  State<MemoMenu> createState() => _MemoMenuState();
}

class _MemoMenuState extends State<MemoMenu> {
  Stream<List<Product>> streamProducts() {
    return FirebaseFirestore.instance
        .collection('meniuMemo')
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs
        .map((doc) => Product(
      id: doc.id,
      name: doc['name'],
      price: doc['price'],
      active: doc['active'],
    ))
        .toList());
  }

  Future<List<String>> getDocIds() async {
    final snapshot =
    await FirebaseFirestore.instance.collection('meniuMemo').get();
    final docIds = snapshot.docs.map((doc) => doc.id).toList();
    return docIds;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meniu Colina'),
      ),
      body: SafeArea(
        child: StreamBuilder<List<Product>>(
          stream: streamProducts(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text('A apărut o eroare.'),
              );
            }

            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            final productList = snapshot.data!;

            return Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                  itemCount: productList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final product = productList[index];
                    if (productList[index].active == true) {
                      return widgetProduct(product: product);
                    }
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
