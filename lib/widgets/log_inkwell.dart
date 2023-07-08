import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_stock_log/screens/stock_detail.dart';

final formatter = DateFormat.yMd();

class StockInkwell extends StatefulWidget {
  const StockInkwell({
    Key? key,
    required this.stock,
    required this.token,
  }) : super(key: key);

  final stock;
  final token;

  @override
  // ignore: library_private_types_in_public_api
  _StockInkwellState createState() => _StockInkwellState();
}

class _StockInkwellState extends State<StockInkwell> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 14,
        ),
        InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => StockDetail(
                  stock: widget.stock,
                  token: widget.token,
                ),
              ),
            );
          },

          splashColor: const Color.fromARGB(255, 178, 178, 178),
          // borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              // borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(colors: [
                Color.fromARGB(65, 0, 0, 0),
                Color.fromARGB(79, 53, 53, 53)
              ], begin: Alignment.topLeft, end: Alignment.bottomRight),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      color: widget.stock['status'] == 'Buy'
                          ? Colors.green
                          : Colors.red,
                      height: 8,
                      width: 8,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(widget.stock['name']),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      widget.stock['quantity'].toString() + "x",
                      style: TextStyle(color: Color.fromARGB(255, 71, 71, 71)),
                    ),
                    const SizedBox(
                      width: 14,
                    ),
                    Text(
                      widget.stock['price'].toString() + ' ₹',
                    ),
                    const SizedBox(
                      width: 14,
                    ),
                    Text(
                      "= ${widget.stock['total'].toStringAsFixed(2)}₹",
                    ),
                    const SizedBox(
                      width: 14,
                    ),
                    Text(
                      formatter.format(
                        DateTime.parse(widget.stock['date']),
                      ),
                      style: const TextStyle(
                          color: Color.fromARGB(255, 68, 68, 68)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
