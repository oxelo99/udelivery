import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udelivery/product_cart_widget.dart';
import 'cart_class.dart';
import 'order_page.dart';
import 'order_class.dart';
import 'theme_data.dart';

class CartPage extends StatefulWidget {
  MyOrder currentOrder;
  @override
  CartPage({
    super.key,
    required this.currentOrder,
  });

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cos"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: ChangeNotifierProvider<Cart>.value(
                  value: widget.currentOrder.myCart,
                  child: Consumer<Cart>(
                    builder: (context, data, child) {
                      return ListView.builder(
                        itemCount: widget.currentOrder.myCart.cartList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ProductCartWidget(
                            product: data.cartList[index],
                            productCart: data,
                            index: index,
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(20),
        child: ChangeNotifierProvider<Cart>.value(
          value: widget.currentOrder.myCart,
          child: Consumer<Cart>(
            builder: (context, cart, child) => Container(
              width: 300,
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OrderPage(currentOrder: widget.currentOrder,)));
                },
                backgroundColor: MyTheme.buttonColor(context),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "Comanda ${widget.currentOrder.myCart.cartList.length} pentru ${widget.currentOrder.myCart.total().toStringAsFixed(2)} lei",
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


