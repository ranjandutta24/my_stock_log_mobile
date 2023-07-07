import 'package:flutter/material.dart';
import 'package:my_stock_log/services/stock_service.dart';

class StockDetail extends StatefulWidget {
  const StockDetail({super.key, required this.stock, required this.token});
  final stock;
  final token;

  @override
  State<StockDetail> createState() => _StockDetailState();
}

class _StockDetailState extends State<StockDetail> {
  deleteOneStock() async {
    var response = await deleteStock(widget.stock['_id'], widget.token);
    if (response.statusCode == 200) {
      print(response.body);

      Navigator.of(context).pop();
      setState(() {
        // stockList = json.decode(response.body);
        // show = true;
      });
      // stockName = stockList.map((item) => item['name'].toString()).toList();
      // print(stockName);
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    print(widget.stock);
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail'),
      ),
      body: Column(children: [
        Text(widget.stock['name']),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: deleteOneStock, child: Text('Delete')),
            const SizedBox(
              width: 14,
            ),
            ElevatedButton(onPressed: () {}, child: Text('Edit'))
          ],
        )
      ]),
    );
  }
}
