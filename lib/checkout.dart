import 'package:flutter/material.dart';
import 'product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CheckOut extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Product> args = ModalRoute.of(context).settings.arguments;

    Future<http.Response> checkOutButton() {
      return http.post(
        'http://mshflutter.atwebpages.com/checkout.php',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(args),
      );
    }

    List<Widget> ocList = [];
    int sum = 0;

    ocList.add(Text(
      "Order is Ready",
      style: TextStyle(fontSize: 30.0),
    ));
    for (var p in args) {
      ocList.add(orderCard(p.name, p.price));
      sum += int.parse(p.price);
    }
    ocList.add(Divider(
      color: Colors.black,
    ));
    ocList.add(Row(
      children: <Widget>[Spacer(), Text("Total $sum\$")],
    ));
    ocList.add(Row(
      children: <Widget>[
        Expanded(
          child: RaisedButton(
            onPressed: () {
              print(checkOutButton());
              Navigator.pop(context);
            },
            color: Colors.green,
            child: Text("Check out"),
          ),
        ),
      ],
    ));
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
          child: Column(
            children: ocList,
          ),
        ),
      ),
    );
  }

  Widget orderCard(String name, String price) {
    return Row(
      children: <Widget>[
        Text(
          name,
          style: TextStyle(fontSize: 20.0),
        ),
        Spacer(),
        Text(
          price + "\$",
          style: TextStyle(fontSize: 20.0),
        ),
      ],
    );
  }
}
