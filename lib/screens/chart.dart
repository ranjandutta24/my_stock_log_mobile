import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:my_stock_log/services/stock_service.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class ChartScreen extends StatefulWidget {
  const ChartScreen({super.key, required this.token});
  final String token;
  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  List stockList = [];
  var totalV;
  var show = false;
  Map<String, double> dataMap = {};
  List<_PieData> listStocks = [];
  getAllStock() async {
    var response = await getStock(widget.token, null);
    if (response.statusCode == 200) {
      setState(() {
        stockList = json.decode(response.body);
        calculateTotal(stockList);
        returnMap(stockList);
      });
    } else {}
  }

  double calculateTotal(List<dynamic> stockData) {
    double total = stockData.fold(0, (double accumulator, dynamic el) {
      return accumulator +
          (el['status'] == 'Sell' ? -el['total'] : el['total']);
    });
    totalV = total;
    return total;
  }

  returnMap(main) {
    List<dynamic> chartSet =
        List.from(main.map((item) => item['name']).toSet());

    List<dynamic> series = [];
    for (int i = 0; i < chartSet.length; i++) {
      series.add(main.where((item) => item['name'] == chartSet[i]).fold(
          0,
          (accumulator, el) =>
              accumulator +
              (el['status'] == 'Sell' ? -el['total'] : el['total'])));
    }

    for (int i = 0; i < series.length; i++) {
      if (series[i] > 0) {
        listStocks.add(_PieData(chartSet[i], series[i],
            "${series[i].toStringAsFixed(0)} (${((series[i] / totalV) * 100).toStringAsFixed(1)}%)"));
      }
    }

    setState(() {
      show = true;
    });
  }

  @override
  void initState() {
    super.initState();
    getAllStock();
  }

  List<_PieData> pieData = [
    _PieData('X Value', 10, '10% '),
    _PieData('xed Value1', 20, '20%'),
    _PieData('xed Value2', 25, '25%'),
    _PieData('xed Value3', 15, '15%'),
    _PieData('xed Value4', 17, '17%'),
    _PieData('xed Value5', 13, '13%'),
  ];

// final Meal meal;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: show == true
              ? SfCircularChart(
                  title: ChartTitle(
                      text: totalV.toStringAsFixed(2).toString() + "₹"),
                  legend: Legend(isVisible: true),
                  series: <PieSeries<_PieData, String>>[
                    PieSeries<_PieData, String>(
                        explodeOffset: '5',
                        animationDuration: 900,
                        explode: true,
                        explodeIndex: 0,
                        dataSource: listStocks,
                        xValueMapper: (_PieData data, _) => data.xData,
                        yValueMapper: (_PieData data, _) => data.yData,
                        dataLabelMapper: (_PieData data, _) => data.text,
                        dataLabelSettings: DataLabelSettings(isVisible: true)),
                  ],
                )
              : const SizedBox(
                  height: 50, width: 50, child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}

class _PieData {
  _PieData(this.xData, this.yData, this.text);
  final String xData;
  final num yData;
  final String text;
}
