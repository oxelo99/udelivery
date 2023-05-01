import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'productWidget.dart';
import 'product.dart';

class ColinaMenu extends StatefulWidget {
  const ColinaMenu({Key? key}) : super(key: key);

  @override
  State<ColinaMenu> createState() => _ColinaMenuState();
}

class _ColinaMenuState extends State<ColinaMenu> {

  Future<List<Product>> getProducts() async {
    final docIds = await getDocIds();
    final futures = docIds.map((id) =>
        FirebaseFirestore.instance.collection('produse').doc(id).get());
    final snapshots = await Future.wait(futures);

    final products = snapshots.map((snapshot) => Product(
      id: snapshot.id,
      name: snapshot['name'],
      price: snapshot['price'],
      active: snapshot['active'],
    )).toList();

    return products;
  }

  Future<List<String>> getDocIds() async {
    final snapshot = await FirebaseFirestore.instance.collection('produse').get();
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
        child: FutureBuilder<List<Product>>(
          future: getProducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData) {
              return const Text('No data found');
            } else {
              final productList = snapshot.data!;
              return Container(
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                  itemCount: productList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return widgetProduct(product: productList[index]);
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}