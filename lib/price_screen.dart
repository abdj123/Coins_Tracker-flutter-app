import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedItem = "USD";
  var dataBtc;
  var dataEth;
  var dataLtc;
  String selectedCoin = "BTC";
  //int? a;

  void getdata() async {
    var apiBtc = Uri.parse(
        "https://rest.coinapi.io/v1/exchangerate/BTC/$selectedItem?apikey=FE39FA20-764F-43B4-ABEC-917A04962897");

    var apiEth = Uri.parse(
        "https://rest.coinapi.io/v1/exchangerate/ETH/$selectedItem?apikey=FE39FA20-764F-43B4-ABEC-917A04962897");
    var apiLtc = Uri.parse(
        "https://rest.coinapi.io/v1/exchangerate/LTC/$selectedItem?apikey=FE39FA20-764F-43B4-ABEC-917A04962897");

    http.Response response1 = await http.get(apiBtc);
    http.Response response2 = await http.get(apiEth);
    http.Response response3 = await http.get(apiLtc);

    if ((response1.statusCode == 200) &
        (response2.statusCode == 200) &
        (response3.statusCode == 200)) {
      var temp1 = response1.body;
      dataBtc = jsonDecode(temp1.toString())["rate"];
      dataBtc = dataBtc.round();

      var temp2 = response2.body;
      dataEth = jsonDecode(temp2.toString())["rate"];
      dataEth = dataEth.round();

      var temp3 = response3.body;
      dataLtc = jsonDecode(temp3.toString())["rate"];
      dataLtc = dataLtc.round();
    } else {
      print(response1.statusCode);
    }
  }

  List<DropdownMenuItem> getDropDownItems() {
    List<DropdownMenuItem<String>> dropdowItems = [];
    for (String cur in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(cur),
        value: cur,
      );

      dropdowItems.add(newItem);
    }
    return dropdowItems;
  }

  @override
  Widget build(BuildContext context) {
    getdata();
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = $dataBtc  $selectedItem',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 5, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 ETH = $dataEth  $selectedItem',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 5, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 LTC = $dataLtc  $selectedItem',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: DropdownButton(
                value: selectedItem,
                items: getDropDownItems(),
                onChanged: (value) {
                  setState(() {
                    selectedItem = value;
                  });
                }),
          ),
        ],
      ),
    );
  }
}
