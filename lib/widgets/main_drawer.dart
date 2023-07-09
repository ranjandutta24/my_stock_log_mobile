import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_stock_log/screens/stock_log.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({
    super.key,
  });

  // final void Function(String identifier) onSelectScreen;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              DrawerHeader(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Theme.of(context).colorScheme.primaryContainer,
                  Theme.of(context)
                      .colorScheme
                      .primaryContainer
                      .withOpacity(0.8),
                ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
                child: Row(
                  children: [
                    Icon(
                      Icons.receipt_long,
                      size: 48,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(
                      width: 14,
                    ),
                    Text(
                      'My Stock Log',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ],
                ),
              ),
              ListTile(
                // leading: Image.asset(
                //   'assets/images/dashboard.png',
                //   height: 30,
                //   width: 30,
                //   fit: BoxFit.cover,
                // ),
                title: Text(
                  'Dashboard',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Color.fromARGB(255, 81, 81, 81),
                        fontSize: 22,
                      ),
                ),
                onTap: () {},
              ),
              ListTile(
                // leading: Image.asset(
                //   'assets/images/dashboard.png',
                //   height: 30,
                //   width: 30,
                //   fit: BoxFit.cover,
                // ),
                title: Text(
                  'Stock Log',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Color.fromARGB(255, 81, 81, 81),
                        fontSize: 22,
                      ),
                ),
                onTap: () {},
              ),
              ListTile(
                // leading: Image.asset(
                //   'assets/images/dashboard.png',
                //   height: 30,
                //   width: 30,
                //   fit: BoxFit.cover,
                // ),
                title: Text(
                  'Log Out',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Color.fromARGB(255, 81, 81, 81),
                        fontSize: 22,
                      ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Develop By Ranjan Dutta @2023',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
