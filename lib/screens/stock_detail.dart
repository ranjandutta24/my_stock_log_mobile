import 'package:flutter/material.dart';
import 'package:my_stock_log/services/stock_service.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

class StockDetail extends StatefulWidget {
  const StockDetail({super.key, required this.stock, required this.token});
  final dynamic stock;
  final String token;

  @override
  State<StockDetail> createState() => _StockDetailState();
}

class _StockDetailState extends State<StockDetail> {
  deleteOneStock() async {
    var response = await deleteStock(widget.stock['_id'], widget.token);
    if (response.statusCode == 200) {
      // print(response.body);

      // ignore: use_build_context_synchronously
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Detail'),
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(10),
              color: const Color.fromARGB(68, 52, 52, 52),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        widget.stock['name'],
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Container(
                        color: widget.stock['status'] == 'Buy'
                            ? Colors.green
                            : Colors.red,
                        height: 10,
                        width: 10,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    formatter.format(
                      DateTime.parse(widget.stock['date']),
                    ),
                    style: const TextStyle(
                        fontSize: 19, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${widget.stock['quantity']} x',
                        style: const TextStyle(
                            fontSize: 19, fontWeight: FontWeight.w400),
                      ),
                      Text(
                        "${widget.stock['price']} ₹",
                        style: const TextStyle(
                            fontSize: 19, fontWeight: FontWeight.w400),
                      ),
                      Text(
                        " = ${widget.stock['total']} ₹",
                        style: const TextStyle(
                            fontSize: 19, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text('Delete'),
                          content:
                              const Text('Do you want to delete this demand?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(ctx);
                              },
                              child: const Text('No'),
                            ),
                            TextButton(
                              onPressed: () {
                                deleteOneStock();
                                Navigator.pop(ctx);
                                Navigator.pop(ctx);
                              },
                              child: const Text('Yes'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: const Text('Delete')),
                const SizedBox(
                  width: 14,
                ),
                ElevatedButton(onPressed: () {}, child: const Text('Edit'))
              ],
            )
          ],
        ),
      ),
    );
  }
}
