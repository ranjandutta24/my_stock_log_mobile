import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_stock_log/screens/add_stock.dart';
import 'package:my_stock_log/services/user_service.dart';
import 'package:my_stock_log/widgets/log_inkwell.dart';

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
      print(stockList);
      setState(() {
        stockList = json.decode(response.body);
        show = true;
      });
    } else {
      print(response.body);
    }
  }

  void _addItem() async {
    // final newItem = await Navigator.of(context).push<GroceryItem>(
    final newItem = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const NewItem(),
      ),
    );

    if (newItem == null) {
      return;
    }

    setState(() {
      // _groceryItems.add(newItem);
    });
  }

  @override
  Widget build(BuildContext context) {
    //getAllStock();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Stock Log'),
          actions: [
            IconButton(
              onPressed: _addItem,
              icon: const Icon(Icons.add),
            )
          ],
        ),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        body: show == true
            ? SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(children: [
                    for (final Map stock in stockList)
                      StockInkwell(stock: stock),
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
