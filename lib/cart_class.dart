import 'package:flutter/material.dart';
import 'package:udelivery/product_class.dart';

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