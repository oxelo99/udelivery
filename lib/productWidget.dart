import 'package:flutter/material.dart';
import 'package:udelivery/product.dart';
import 'theme_data.dart';


class widgetProduct extends StatefulWidget {
  Product product;
  widgetProduct({
    Key? key,
    required this.product
  }) : super(key: key);

  @override
  State<widgetProduct> createState() => _widgetProductState();
}

class _widgetProductState extends State<widgetProduct> {
  var qty = ['1', '2', '3', '4'];
  late String _selectedValue=qty[1];

  @override
  Widget build(BuildContext context) {
    return Container(
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
              ),
              Expanded(
                  flex: 1,
                  child: IconButton(
                      onPressed: () {},
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
    );
  }
}