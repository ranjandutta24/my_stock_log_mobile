import 'package:flutter/material.dart';
import 'package:my_stock_log/screens/stock_log.dart';

class TabularScreen extends StatelessWidget {
  const TabularScreen({super.key, required this.data, required this.token});
  final data;
  final token;
  @override
  Widget build(BuildContext context) {
    return Column(
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
          child: Text('Stock Log'),
        )
      ],
    );
  }
}
