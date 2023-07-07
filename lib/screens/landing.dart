// import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:my_stock_log/screens/chart.dart';
import 'package:my_stock_log/screens/demo.dart';
import 'package:my_stock_log/screens/stock_log.dart';
import 'package:my_stock_log/screens/tabular.dart';
import 'package:my_stock_log/widgets/main_drawer.dart';

class Landing extends StatefulWidget {
  Landing({super.key, required this.data, required this.token});
  var data;
  var token;

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = TabularScreen(
      data: widget.data,
      token: widget.token,
    );

    // var activePageTitle = "Categories";

    if (_selectedPageIndex == 1) {
      activePage = ChartScreen();
      // activePageTitle = "Favorites";
    }
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dashboard'),
        ),
        drawer: const MainDrawer(),
        body: activePage,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedPageIndex,
          onTap: _selectPage,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.table_chart), label: "Tab View"),
            BottomNavigationBarItem(
                icon: Icon(Icons.graphic_eq), label: "Graph View"),
          ],
        ),
      ),
    );
  }
}
