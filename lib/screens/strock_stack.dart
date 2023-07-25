import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_stock_log/services/stock_service.dart';
import 'package:my_stock_log/widgets/log_inkwell.dart';

class StockStack extends StatefulWidget {
  const StockStack({super.key, required this.stock, required this.token});
  final stock;
  final token;
  @override
  State<StockStack> createState() {
    return _StockStackScreenState();
  }
}

class _StockStackScreenState extends State<StockStack> {
  List stockList = [];
  bool show = false;
  // call search api
  getAllStock() async {
    print('object');
    var response =
        await getStock(widget.token, {'name': widget.stock[0]['name']});
    if (response.statusCode == 200) {
      setState(() {
        stockList = json.decode(response.body);
        show = true;
        print(stockList);
      });
      // stockName = stockList.map((item) => item['name'].toString()).toList();
      // print(stockName);
    } else {}
  }

  @override
  void initState() {
    super.initState();

    getAllStock();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.stock);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.stock[0]['name']),
        ),
        body: show == true
            ? SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(children: [
                    for (final Map stock in stockList)
                      StockInkwell(
                        stock: stock,
                        token: widget.token,
                      ),
                    const SizedBox(
                      height: 14,
                    )
                  ]),
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
