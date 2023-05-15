import 'package:flutter/material.dart';
import 'package:udelivery/product.dart';
import 'theme_data.dart';
import 'cart_page.dart';

class WidgetProduct extends StatefulWidget {
  final Product product;
  final Cart productCart;

  const WidgetProduct(
      {Key? key, required this.product, required this.productCart})
      : super(key: key);

  @override
  State<WidgetProduct> createState() => _WidgetProductState();
}

class _WidgetProductState extends State<WidgetProduct> {
  var qty = ['1', '2', '3', '4'];

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
                /*Expanded(
                    flex: 1,
                    child:  DropdownButton(
                      value: _selectedValue,
                      items: qty.map(
                              (e){
                            return DropdownMenuItem(value: e, child: Text(e, style: TextStyle(color: MyTheme.textColor(context)),),);
                          }
                      ).toList(),
                      onChanged: (val){
                        setState(() {
                          _selectedValue = val as String;

                        });
                      },
                    )
                ),*/
                Expanded(
                    flex: 1,
                    child: IconButton(
                        onPressed: () {
                          widget.productCart.addProduct(widget.product);
                        },
                        icon: Icon(
                          Icons.add_circle_rounded,
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
