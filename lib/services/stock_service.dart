// https://busy-bee-poncho.cyclic.app/api//auth

// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

var baseURL = 'https://busy-bee-poncho.cyclic.app/api/';

getStock(body, params) async {
  try {
    return await http.get(
      params == null
          ? Uri.parse('$baseURL/stocks')
          : Uri.parse('$baseURL/stocks').replace(queryParameters: params),
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

getCurrentStock(body) async {
  try {
    return await http.get(
      Uri.parse('$baseURL/stocks/currentstock'),
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

deleteStock(id, token) async {
  return await http.delete(
    Uri.parse('$baseURL/stocks/$id'),
    headers: {'Content-Type': 'application/json', 'x-auth-token': token},
  );
}
