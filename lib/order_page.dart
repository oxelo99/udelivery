import 'package:flutter/material.dart';
import 'package:udelivery/product_class.dart';
import 'package:udelivery/theme_data.dart';
import 'main_page.dart';
import 'order_class.dart';

class OrderPage extends StatefulWidget {
  MyOrder currentOrder = MyOrder.late();

  OrderPage({
    required this.currentOrder,
    Key? key,
  }) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final _buildingNumberController = TextEditingController();
  final _floorController = TextEditingController();
  final _roomController = TextEditingController();
  String errorMessage = '';

  bool dataCheck() {
    if (_floorController.text
        .trim()
        .isEmpty) {
      setState(() {
        errorMessage = 'Completeaza etajul!';
      });
      return false;
    } else if (_roomController.text
        .trim()
        .isEmpty) {
      setState(() {
        errorMessage = 'Completeaza numarul camerei!';
      });
      return false;
    } else if (_buildingNumberController.text
        .trim()
        .isEmpty) {
      setState(() {
        errorMessage = 'Completeaza numarul caminului!';
      });
      return false;
    } else if (widget.currentOrder.myCart.cartList.isEmpty) {
      setState(() {
        errorMessage = 'Cosul este gol. Adauga cateva produse!';
      });
      return false;
    } else {
      widget.currentOrder.address.room = _roomController.text.trim();
      widget.currentOrder.address.floor = _floorController.text.trim();
      widget.currentOrder.address.buildingNumber =
          _buildingNumberController.text.trim();
      return true;
    }
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
                          hintText: 'Nume: ${widget.currentOrder.currentUser.lastName}',
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
                          hintText: 'Prenume: ${widget.currentOrder.currentUser.firstName}',
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
                        'Numar de telefon: ${widget.currentOrder.currentUser.phoneNumber}',
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
                          hintText: 'Complex ${widget.currentOrder.complex}',
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
                        index < widget.currentOrder.myCart.cartList.length;
                        index++)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${widget.currentOrder.myCart.cartList[index].name} x${widget.currentOrder.myCart.cartList[index].qty}',
                            style: TextStyle(
                                color: MyTheme.textColor(context),
                                fontSize: 15),
                          ),
                          Text(
                            '${(double.parse(widget.currentOrder.myCart.cartList[index].price) * widget.currentOrder.myCart.cartList[index].qty).toStringAsFixed(2)} Lei',
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
                      '${widget.currentOrder.myCart.total().toStringAsFixed(2)} Lei',
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
                      future: widget.currentOrder.getDeliveryFee(),
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
                            '${widget.currentOrder.deliveryFee.toStringAsFixed(2)} Lei',
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
                      future: widget.currentOrder.getDeliveryFee(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        }
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }
                        if (snapshot.hasData) {
                          widget.currentOrder.total = widget.currentOrder.myCart.total() + widget.currentOrder.deliveryFee;
                          return Text(
                            '${widget.currentOrder.total.toStringAsFixed(2)} Lei',
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
                      if (dataCheck()) {
                        showDialog(
                          context: context,
                          builder: (context) => FutureBuilder(
                            future: widget.currentOrder.uploadData(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return const AlertDialog(
                                  title: Text('Încărcare în curs'),
                                  content: Center(child: CircularProgressIndicator()),
                                );
                              } else {
                                if (snapshot.hasError) {
                                  return AlertDialog(
                                    title: const Text('Eroare'),
                                    content: Text('A apărut o eroare: ${snapshot.error}'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  );
                                } else {
                                  List<Product> emptyList=[];
                                  widget.currentOrder.myCart.cartList=emptyList;
                                  return AlertDialog(
                                    title: const Text('Succes'),
                                    content: const Text('Comanda a fost plasată cu succes.'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  MyApp(currentOrder: widget.currentOrder),
                                            ),
                                          );
                                        },
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  );
                                }
                              }
                            },
                          ),
                        );
                        setState(() {
                          errorMessage = '';
                        });
                      }
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
                        ),
                      ),
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
