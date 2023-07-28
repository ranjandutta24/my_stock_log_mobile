// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_stock_log/screens/stock_log.dart';
import 'package:my_stock_log/screens/strock_stack.dart';

import '../services/stock_service.dart';

class TabularScreen extends StatefulWidget {
  const TabularScreen({super.key, required this.data, required this.token});
  final data;
  final String token;

  @override
  State<TabularScreen> createState() => _TabularScreenState();
}

class _TabularScreenState extends State<TabularScreen> {
  List stockList = [];
  bool load = true;

  double elv = 2;
  currentStock() async {
    var response = await getCurrentStock(widget.token);
    if (response.statusCode == 200) {
      setState(() {
        stockList = json.decode(response.body);
        load = false;
      });

      // print(stockList);
    } else {}
  }

  @override
  void initState() {
    super.initState();
    currentStock();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome ' + widget.data['name'],
            style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 115, 115, 115)),
          ),
          const SizedBox(
            height: 24,
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 20),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    width: 2.0, color: Color.fromARGB(255, 131, 190, 236)),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Material(
                  borderRadius: BorderRadius.circular(7),
                  elevation: 3,
                  child: InkWell(
                    splashColor: const Color.fromARGB(255, 255, 255, 255),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => StockLog(
                            token: widget.token,
                          ),
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(7),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: const Color.fromARGB(66, 167, 167, 167),
                      ),
                      padding: const EdgeInsets.only(top: 10),
                      // color: const Color.fromARGB(66, 167, 167, 167),
                      height: 50,
                      width: 70,
                      child: Column(
                        children: const [
                          Icon(
                            Icons.list_alt,
                            color: Color.fromARGB(255, 73, 152, 243),
                          ),
                          Text(
                            'Stock log',
                            style: TextStyle(
                                fontSize: 10,
                                color: Color.fromARGB(255, 42, 127, 224),
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Material(
                  borderRadius: BorderRadius.circular(7),
                  elevation: 3,
                  child: InkWell(
                    splashColor: const Color.fromARGB(255, 154, 154, 154),
                    onTap: () {},
                    borderRadius: BorderRadius.circular(7),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: const Color.fromARGB(66, 167, 167, 167),
                      ),
                      padding: const EdgeInsets.only(top: 10),
                      // color: const Color.fromARGB(66, 167, 167, 167),
                      height: 50,
                      width: 70,
                      child: Column(
                        children: const [
                          Icon(
                            Icons.auto_fix_normal_outlined,
                            color: Color.fromARGB(255, 145, 38, 216),
                          ),
                          Text(
                            'Filter',
                            style: TextStyle(
                                fontSize: 10,
                                color: Color.fromARGB(255, 145, 38, 216),
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Material(
                  borderRadius: BorderRadius.circular(7),
                  elevation: elv,
                  child: InkWell(
                    onTapDown: (details) {
                      setState(() {
                        elv = 0;
                      });
                    },
                    onTapUp: (details) {
                      setState(() {
                        elv = 2;
                      });
                    },
                    onTap: () {},
                    borderRadius: BorderRadius.circular(7),
                    // splashColor: Color.fromARGB(255, 255, 255, 255),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: const Color.fromARGB(66, 167, 167, 167),
                      ),

                      padding: const EdgeInsets.only(top: 10),
                      // color: const Color.fromARGB(66, 167, 167, 167),
                      height: 50,
                      width: 70,
                      child: Column(
                        children: const [
                          Icon(
                            Icons.extension_rounded,
                            color: Color.fromARGB(255, 16, 155, 23),
                          ),
                          Text(
                            'Extra',
                            style: TextStyle(
                                fontSize: 10,
                                color: Color.fromARGB(255, 16, 155, 23),
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            padding:
                const EdgeInsets.only(left: 8, right: 3, top: 5, bottom: 5),
            color: const Color.fromARGB(255, 230, 230, 230),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                Expanded(
                  flex: 4,
                  child: Text(
                    'Stock',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text('Unit',
                      style: TextStyle(fontWeight: FontWeight.w600)),
                ),
                Expanded(
                  flex: 3,
                  child: Text('Total',
                      style: TextStyle(fontWeight: FontWeight.w600)),
                ),
                Expanded(
                  flex: 2,
                  child: Text('Average',
                      style: TextStyle(fontWeight: FontWeight.w600)),
                ),
              ],
            ),
          ),
          load == false
              ? Expanded(
                  child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          for (final Map stock in stockList)
                            Material(
                              elevation: 6,
                              child: Container(
                                padding: const EdgeInsets.only(
                                    top: 13, bottom: 13, right: 0, left: 8),
                                // height: 60,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Text(stock['name']),
                                    GestureDetector(
                                      onTap: () {
                                        var specificStock = stockList
                                            .where((element) =>
                                                element['name'] ==
                                                stock['name'])
                                            .toList();
                                        // print(specificStock);
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (ctx) => StockStack(
                                              token: widget.token,
                                              stock: specificStock,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            flex: 4,
                                            child: Text(stock['name']),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                                stock['quantity'].toString()),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Text(
                                              stock['total']
                                                  .toStringAsFixed(2)
                                                  .toString(),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              (stock['total'] /
                                                      stock['quantity'])
                                                  .toStringAsFixed(2)
                                                  .toString(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                )
              : const Text('')
        ],
      ),
    );
  }
}
