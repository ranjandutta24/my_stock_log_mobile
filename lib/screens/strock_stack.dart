import 'package:flutter/material.dart';

class StockStack extends StatefulWidget {
  const StockStack({super.key, required this.stock});
  final stock;
  @override
  State<StockStack> createState() {
    return _StockStackScreenState();
  }
}

class _StockStackScreenState extends State<StockStack> {
  @override
  Widget build(BuildContext context) {
    print(widget.stock);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('sdad'),
        ),
      ),
    );
  }
}
