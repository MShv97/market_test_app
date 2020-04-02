import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:market_test_app/networking.dart';
import 'product.dart';
import 'checkout.dart';

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  void initState() {
    super.initState();
  }

  List<bool> pListStatus = [];
  List<Product> pList = [];

  Future<List<Product>> _updateUI() async {
    NetworkHelper networkHelper =
        NetworkHelper("http://mshflutter.atwebpages.com/connect.php");
    var data = await networkHelper.getData();
    int i = 0;
    pList.clear();
    for (var d in data) {
      Product p = Product(
        id: d["id"],
        name: d["Name"],
        price: d["price"].toString(),
        desc: d["description"],
        stoke: d["storage"].toString(),
        img: "http://mshflutter.atwebpages.com/img_get.php?id=${d["id"]}",
      );

      pList.add(p);
      i++;
      if (i >= pListStatus.length) {
        pListStatus.add(false);
      }
    }
    return pList;
  }

  int itemInChart = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Market"),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: GestureDetector(
                  onTap: () {
                    List<Product> readyOrder = [];
                    for (int i = 0; i < pListStatus.length; i++) {
                      if (pListStatus[i]) readyOrder.add(pList[i]);
                    }
                    Navigator.pushNamed(context, '/checkout',
                            arguments: readyOrder)
                        .then((value) {
                      setState(() {});
                    });
                  },
                  child: Badge(
                    badgeContent: Text(itemInChart.toString()),
                    child: Icon(Icons.shopping_cart),
                  ),
                ),
              )
            ],
          ),
          body: Container(
            color: Colors.black12,
            child: FutureBuilder(
              future: _updateUI(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return Container(
                    child: Center(
                      child: Text("Loading..."),
                    ),
                  );
                }
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return productsCard(snapshot.data[index], index);
                    });
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget productsCard(var p, int index) {
    return GestureDetector(
      onTap: () {
        pListStatus[index] = !pListStatus[index];
        if (pListStatus[index])
          itemInChart++;
        else
          itemInChart--;
        setState(() {});
      },
      child: Card(
        color: pListStatus[index] ? Colors.grey : Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          p.name,
                          style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 15.0),
                          child: Text(
                            p.desc,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Image.network(
                    p.img,
                    width: 150.0,
                    height: 150.0,
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Text(
                    "Price: ${p.price}\$",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Text("Stoke: ${p.stoke}"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
