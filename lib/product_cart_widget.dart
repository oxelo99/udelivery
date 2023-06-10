import 'package:flutter/material.dart';
import 'package:udelivery/product_class.dart';
import 'package:udelivery/theme_data.dart';
import 'cart_class.dart';

class ProductCartWidget extends StatefulWidget {
  final Product product;
  final Cart productCart;
  final int index;

  const ProductCartWidget(
      {Key? key,
        required this.product,
        required this.productCart,
        required this.index})
      : super(key: key);

  @override
  State<ProductCartWidget> createState() => _ProductCartWidgetState();
}

class _ProductCartWidgetState extends State<ProductCartWidget> {
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