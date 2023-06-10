import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:udelivery/cart_page.dart';
import 'order_class.dart';
import 'product_menu_widget.dart';
import 'product_class.dart';

class MemoMenu extends StatefulWidget {
  MyOrder currentOrder;
  MemoMenu({
    required this.currentOrder,
    super.key,
  });

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meniu Memo'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CartPage(currentOrder: widget.currentOrder)));
              },
              child: const Icon(
                Icons.shopping_basket,
              ),
            ),
          )
        ],
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
            final activeProducts =
            productList.where((product) => product.active == true).toList();
            widget.currentOrder.complex='Memo';
            widget.currentOrder.address.complex ='Memo';
            return Container(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                itemCount: activeProducts.length,
                itemBuilder: (BuildContext context, int index) {
                  final product = activeProducts[index];
                  return ProductWidget(
                    product: product,
                    productCart: widget.currentOrder.myCart,
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
