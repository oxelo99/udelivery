import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udelivery/user.dart';
import 'order.dart';
import 'product.dart';
import 'theme_data.dart';

class Cart extends ChangeNotifier {
  List<Product> cartList = [];

  Cart();

  void addProduct(Product product) {
    cartList.add(product);
    notifyListeners();
  }

  void removeProduct(Product product) {
    cartList.remove(product);
    notifyListeners();
  }

  double total() {
    double total = 0;
    for (int index = 0; index < cartList.length; index++) {
      total += double.parse(cartList[index].price) * cartList[index].qty;
    }

    return total;
  }
}

class CartPage extends StatefulWidget {
  final Cart myCart;
  final String complex;
  final MyUser currentUser;
  @override
  const CartPage({
    super.key,
    required this.myCart,
    required this.complex,
    required this.currentUser,
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
                  value: widget.myCart,
                  child: Consumer<Cart>(
                    builder: (context, data, child) {
                      return ListView.builder(
                        itemCount: widget.myCart.cartList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return CartWidget(
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
          value: widget.myCart,
          child: Consumer<Cart>(
            builder: (context, cart, child) => Container(
              width: 300,
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OrderPage(
                                complex: widget.complex, myCart: widget.myCart, currentUser: widget.currentUser,

                              )));
                },
                backgroundColor: MyTheme.buttonColor(context),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "Comanda ${widget.myCart.cartList.length} pentru ${widget.myCart.total().toStringAsFixed(2)} lei",
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

class CartWidget extends StatefulWidget {
  final Product product;
  final Cart productCart;
  final int index;

  const CartWidget(
      {Key? key,
      required this.product,
      required this.productCart,
      required this.index})
      : super(key: key);

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  List<int> qty = [1, 2, 3, 4];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Container(
        margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
        padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
        decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(0, 1), // changes position of shadow
              ),
            ]),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 6,
                  child: Text(
                    widget.product.name,
                    style: TextStyle(
                      color: MyTheme.textColor(context),
                    ),
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: DropdownButton(
                      value: widget.productCart.cartList[widget.index].qty,
                      items: qty.map((e) {
                        return DropdownMenuItem(
                          value: e,
                          child: Text(
                            '$e',
                            style: TextStyle(color: MyTheme.textColor(context)),
                          ),
                        );
                      }).toList(),
                      onChanged: (val) {
                        setState(() {
                          widget.productCart.cartList[widget.index].qty =
                              val ?? 0;
                        });
                      },
                    )),
                Expanded(
                    flex: 1,
                    child: IconButton(
                        onPressed: () {
                          widget.productCart.removeProduct(widget.product);
                        },
                        icon: Icon(
                          Icons.remove_circle_rounded,
                          color: MyTheme.buttonColor(context),
                        ))),
              ],
            ),
            Row(children: [
              Text(
                '${widget.product.price} lei',
                style: TextStyle(
                  color: MyTheme.buttonColor(context),
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
