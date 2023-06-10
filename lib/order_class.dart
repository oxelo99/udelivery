import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:udelivery/product_class.dart';
import 'package:udelivery/user_class.dart';

import 'address_class.dart';
import 'cart_class.dart';

class MyOrder{
  String complex='';
  Cart myCart = Cart();
  MyUser currentUser = MyUser();
  double total =0;
  double deliveryFee=0;
  Address address = Address.late();

  MyOrder({required this.complex,
    required this.myCart,
    required this.currentUser,
  });

  MyOrder.late();

  Future<double> getDeliveryFee() async {
    final dfSnapshot = await FirebaseFirestore.instance
        .collection('taxes')
        .doc('DeliveryFee')
        .get();
    deliveryFee = double.parse(dfSnapshot['value']);
    return deliveryFee;
  }

  Future<void> uploadData() async {
    CollectionReference ordersRef =
    FirebaseFirestore.instance.collection('orders');
    DocumentReference newOrder = await ordersRef.add({
      'Products:': myCart.cartList
          .map((Product product) => product.toMap())
          .toList(),
      'User Details:': currentUser.toMap(),
      'Address:': address.toMap(),
      'Status': 'In procesare',
      'Subtotal': myCart.total(),
      'Delivery Fee': deliveryFee,
      'Total': myCart.total()+deliveryFee,
      'Date & Time': DateTime.now(),

    });
    await newOrder.update({'Order id': newOrder.id});
  }
}