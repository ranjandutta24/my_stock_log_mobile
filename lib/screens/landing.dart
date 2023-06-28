// import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_stock_log/screens/demo.dart';
import 'package:my_stock_log/screens/stock_log.dart';
import 'package:my_stock_log/widgets/main_drawer.dart';

class Landing extends StatelessWidget {
  Landing({super.key, required this.data, required this.token});
  var data;
  var token;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dashboard'),
        ),
        drawer: const MainDrawer(),
        body: Column(
          children: [
            Text('Welcome ' + data['name']),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => StockLog(
                        token: token,
                      ),
                    ),
                  );
                },
                child: Text('Stock Log'))
          ],
        ),
      ),
    );
  }
}
