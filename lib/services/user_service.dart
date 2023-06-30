// https://busy-bee-poncho.cyclic.app/api//auth

// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

userlogin(body) async {
  try {
    return await http.post(
        Uri.parse('https://busy-bee-poncho.cyclic.app/api//auth'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: body);
  } catch (error) {
    SnackBar(
      duration: const Duration(seconds: 3),
      content: const Center(
        child: Text('api call error'),
      ),
      action: SnackBarAction(label: '', onPressed: () {}),
    );
  }
}

// /users/me

me(body) async {
  try {
    return await http.get(
      Uri.parse('https://busy-bee-poncho.cyclic.app/api//users/me'),
      headers: {'Content-Type': 'application/json', 'x-auth-token': body},
    );
  } catch (error) {
    SnackBar(
      duration: const Duration(seconds: 3),
      content: const Center(
        child: Text('api call error'),
      ),
      action: SnackBarAction(label: '', onPressed: () {}),
    );
  }
}

getStock(body) async {
  try {
    return await http.get(
      Uri.parse('https://busy-bee-poncho.cyclic.app/api//stocks'),
      headers: {'Content-Type': 'application/json', 'x-auth-token': body},
    );
  } catch (error) {
    SnackBar(
      duration: const Duration(seconds: 3),
      content: const Center(
        child: Text('api call error'),
      ),
      action: SnackBarAction(label: '', onPressed: () {}),
    );
  }
}

addStock(body) async {
  try {
    return await http.post(
        Uri.parse('https://busy-bee-poncho.cyclic.app/api//auth'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: body);
  } catch (error) {
    SnackBar(
      duration: const Duration(seconds: 3),
      content: const Center(
        child: Text('api call error'),
      ),
      action: SnackBarAction(label: '', onPressed: () {}),
    );
  }
}
