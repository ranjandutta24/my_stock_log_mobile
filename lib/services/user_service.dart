// https://busy-bee-poncho.cyclic.app/api//auth

// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

var baseURL = 'https://busy-bee-poncho.cyclic.app/api/';

userlogin(body) async {
  return await http.post(Uri.parse('$baseURL/auth'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: body);
}

userRegister(body) async {
  return await http.post(Uri.parse('$baseURL/users'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: body);
}

// /users/me

me(body) async {
  try {
    return await http.get(
      Uri.parse('$baseURL/users/me'),
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
      Uri.parse('$baseURL/stocks'),
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

addStock(body, token) async {
  return await http.post(Uri.parse('$baseURL/stocks/'),
      headers: {'Content-Type': 'application/json', 'x-auth-token': token},
      body: body);
}
