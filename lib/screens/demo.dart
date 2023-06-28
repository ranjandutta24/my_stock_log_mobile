// import 'package:fl_chart_app/presentation/resources/app_resources.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// import 'presentation/router/app_router.dart';

LineChartData sampleData() {
  return LineChartData(
    lineTouchData: LineTouchData(enabled: false),
    gridData: FlGridData(show: false),
    titlesData: FlTitlesData(show: false),
    borderData: FlBorderData(show: false),
    lineBarsData: [
      LineChartBarData(
        spots: [
          FlSpot(0, 1),
          FlSpot(1, 1.5),
          FlSpot(2, 2),
          FlSpot(3, 2.5),
          FlSpot(4, 3),
          FlSpot(5, 3.5),
        ],
        isCurved: true,
        color: Colors.blue,
        barWidth: 2,
      ),
    ],
  );
}

LineChart lineChart() {
  return LineChart(
    sampleData(),
    swapAnimationDuration: Duration(milliseconds: 500),
  );
}

// Usage in a widget
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('FL Chart Example'),
    ),
    body: Center(
      child: Container(
        height: 300,
        child: lineChart(),
      ),
    ),
  );
}

PieChartData sampleData1() {
  return PieChartData(
    sections: [
      PieChartSectionData(
        color: Colors.green,
        value: 10,
        title: '10%',
        radius: 50,
        titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      PieChartSectionData(
        color: Colors.red,
        value: 20,
        title: '20%',
        radius: 70,
        titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      PieChartSectionData(
        color: Colors.blue,
        value: 50,
        title: '50%',
        radius: 50,
        titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      PieChartSectionData(
        color: Colors.orange,
        value: 20,
        title: '20%',
        radius: 40,
        titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    ],
  );
}

PieChart pieChart() {
  return PieChart(
    sampleData1(),
    swapAnimationDuration: Duration(milliseconds: 900),
  );
}
