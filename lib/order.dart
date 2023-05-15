import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:udelivery/home.dart';
import 'package:udelivery/product.dart';
import 'package:udelivery/theme_data.dart';
import 'cart_page.dart';
import 'user.dart';

class OrderPage extends StatefulWidget {
  final String complex;
  final Cart myCart;
  final MyUser currentUser;
  late double total;

  OrderPage({
    required this.complex,
    required this.myCart,
    required this.currentUser,
    Key? key,
  }) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final _buildingNumberController = TextEditingController();
  final _floorController = TextEditingController();
  final _roomController = TextEditingController();
  late double deliveryFee;
  String errorMessage = '';

  Future<double> getDeliveryFee() async {
    final dfSnapshot = await FirebaseFirestore.instance
        .collection('taxes')
        .doc('DeliveryFee')
        .get();
    deliveryFee = double.parse(dfSnapshot['value']);
    return deliveryFee;
  }

  Future<void> uploadData() async {
    Map<String, dynamic> adress = {
      'Building Number': _buildingNumberController.text.trim(),
      'Floor': _floorController.text.trim(),
      'Room': _roomController.text.trim(),
      'Complex': widget.complex,
    };
    Map<String, dynamic> value = {
      'Subtotal': widget.myCart.total(),
      'Delivery Fee': deliveryFee,
      'Total': widget.total,
    };
    if (_floorController.text.trim().isEmpty) {
      setState(() {
        errorMessage='Completeaza etajul!';
      });
    }else if(_roomController.text.trim().isEmpty){
      setState(() {
        errorMessage='Completeaza numarul camerei!';
      });
    }else if(_buildingNumberController.text.trim().isEmpty){
      setState(() {
        errorMessage='Completeaza numarul caminului!';
      });
    }else if(widget.myCart.cartList.isEmpty){
      setState(() {
        errorMessage='Cosul este gol. Adauga cateva produse!';
      });
    }else{
      CollectionReference ordersRef =
      FirebaseFirestore.instance.collection('orders');
      DocumentReference newOrder = await ordersRef.add({
        'Products:': widget.myCart.cartList
            .map((Product product) => product.toMap())
            .toList(),
        'User Details:': widget.currentUser.toMap(),
        'Address:': adress,
        'Status: ': 'In procesare',
        'Value: ': value,
        'Date & Time': DateTime.now(),
      });
      await newOrder.update({'Order id': newOrder.id});
    }


    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Succes'),
          content: const Text('Comanda a fost plasată cu succes.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => MyApp(currentUser: widget.currentUser)),
                );
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Finalizare comanda"),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Text(
                  'Detalii de livrare: ',
                  style: TextStyle(
                      fontSize: 20, color: MyTheme.textColor(context)),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Nume: ${widget.currentUser.lastName}',
                          hintStyle: const TextStyle(color: Colors.grey),
                          enabled: false,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 1,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Prenume: ${widget.currentUser.firstName}',
                          hintStyle: const TextStyle(color: Colors.grey),
                          enabled: false,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText:
                        'Numar de telefon: ${widget.currentUser.phoneNumber}',
                    hintStyle: const TextStyle(color: Colors.grey),
                    enabled: false,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 6,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Complex ${widget.complex}',
                          hintStyle: const TextStyle(color: Colors.grey),
                          enabled: false,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 3,
                      child: TextField(
                        controller: _buildingNumberController,
                        decoration: const InputDecoration(
                          labelText: 'Nr camin',
                        ),
                        style: TextStyle(color: MyTheme.textColor(context)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _floorController,
                        decoration: const InputDecoration(
                          labelText: 'Etaj: ',
                        ),
                        style: TextStyle(color: MyTheme.textColor(context)),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextField(
                        controller: _roomController,
                        decoration: const InputDecoration(
                          labelText: 'Camera: ',
                        ),
                        style: TextStyle(color: MyTheme.textColor(context)),
                      ),
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Produse: ',
                  style: TextStyle(
                      fontSize: 20, color: MyTheme.textColor(context)),
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    for (int index = 0;
                        index < widget.myCart.cartList.length;
                        index++)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${widget.myCart.cartList[index].name} x${widget.myCart.cartList[index].qty}',
                            style: TextStyle(
                                color: MyTheme.textColor(context),
                                fontSize: 15),
                          ),
                          Text(
                            '${(double.parse(widget.myCart.cartList[index].price) * widget.myCart.cartList[index].qty).toStringAsFixed(2)} Lei',
                            style: TextStyle(
                                color: MyTheme.textColor(context),
                                fontSize: 15),
                          )
                        ],
                      ),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Subtotal:',
                      style: TextStyle(
                          color: MyTheme.textColor(context), fontSize: 15),
                    ),
                    Text(
                      '${widget.myCart.total().toStringAsFixed(2)} Lei',
                      style: TextStyle(
                          color: MyTheme.textColor(context), fontSize: 15),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Taxa de livrare:',
                      style: TextStyle(
                          color: MyTheme.textColor(context), fontSize: 15),
                    ),
                    FutureBuilder<double>(
                      future: getDeliveryFee(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        }
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }
                        if (snapshot.hasData) {
                          return Text(
                            '${deliveryFee.toStringAsFixed(2)} Lei',
                            style: TextStyle(
                              color: MyTheme.textColor(context),
                              fontSize: 15,
                            ),
                          );
                        } else {
                          return const Text('No data');
                        }
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total:',
                      style: TextStyle(
                          color: MyTheme.textColor(context), fontSize: 15),
                    ),
                    FutureBuilder<double>(
                      future: getDeliveryFee(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        }
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }
                        if (snapshot.hasData) {
                          widget.total = widget.myCart.total() + deliveryFee;
                          return Text(
                            '${widget.total.toStringAsFixed(2)} Lei',
                            style: TextStyle(
                              color: MyTheme.textColor(context),
                              fontSize: 15,
                            ),
                          );
                        } else {
                          return const Text('No data');
                        }
                      },
                    ),
                  ],
                ),
                Center(
                    child: Text(
                  errorMessage,
                  style: TextStyle(color: MyTheme.textColor(context)),
                )),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: GestureDetector(
                    onTap: () {
                      FutureBuilder(
                        future: uploadData(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else {
                            if (snapshot.hasError) {
                              return Text(
                                  'A apărut o eroare: ${snapshot.error}');
                            }else {
                              return const Text('Datele au fost încărcate cu succes!');
                            }
                          }
                        },
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      decoration: BoxDecoration(
                        color: MyTheme.buttonColor(context),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                          child: Text(
                        'Plaseaza comanda',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
