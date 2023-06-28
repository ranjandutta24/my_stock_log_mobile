import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_stock_log/services/user_service.dart';

class StockLog extends StatefulWidget {
  const StockLog({super.key, required this.token});
  final token;

  @override
  State<StockLog> createState() => _StockLogState();
}

class _StockLogState extends State<StockLog> {
  @override
  void initState() {
    super.initState();
    getAllStock();
  }

  dynamic stockList = [];
  bool show = false;
  getAllStock() async {
    print('call');
    var response = await getStock(widget.token);
    if (response.statusCode == 200) {
      stockList = json.decode(response.body);
      print(stockList);
      setState(() {
        show = true;
      });
    } else {
      print(response.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Stock Log'),
        ),
        body: show == true
            ? SingleChildScrollView(
                child: Column(children: [
                  for (final Map stock in stockList)
                    Row(
                      children: [
                        Text(stock['name']),
                        const SizedBox(
                          width: 14,
                        ),
                        Text(stock['price'].toString()),
                        const SizedBox(
                          width: 14,
                        ),
                        Text(stock['quantity'].toString()),
                      ],
                    ),
                  const SizedBox(
                    height: 14,
                  )
                ]),
              )
            : Text(''),
      ),
    );
  }
}
