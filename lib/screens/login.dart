import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_stock_log/screens/landing.dart';
import 'package:my_stock_log/screens/register.dart';
import 'package:my_stock_log/services/user_service.dart';
import 'package:my_stock_log/widgets/TextField.dart';

class Login extends StatefulWidget {
  const Login({
    super.key,
  });

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController userId = TextEditingController();
  TextEditingController passward = TextEditingController();

  @override
  void dispose() {
    userId.dispose();
    passward.dispose();

    super.dispose();
  }

  var loading = false;

  login() async {
    setState(() {
      loading = true;
    });

    try {
      var response = await userlogin(
        json.encode(
          {'email': userId.text.trim(), 'password': passward.text},
        ),
      );

      if (response.statusCode == 200) {
        var token = json.decode(response.body);
        var response1 = await me(token['jwttoken']);
        if (response1.statusCode == 200) {
          // ignore: use_build_context_synchronously
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => Landing(
                  data: json.decode(response1.body), token: token['jwttoken']),
            ),
          );
        }
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).clearSnackBars();
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 3),
            content: Center(
              child: Text(response.body),
            ),
            action: SnackBarAction(label: '', onPressed: () {}),
          ),
        );
      }
      setState(() {
        loading = false;
      });
    } catch (error) {
      ScaffoldMessenger.of(context).clearSnackBars();
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 3),
          content: const Center(
            child: Text('Login Failed. Please try again later.'),
          ),
          action: SnackBarAction(label: '', onPressed: () {}),
        ),
      );
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 91, 149, 242),
              Color.fromARGB(255, 44, 117, 235),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextField(
                    color: const Color.fromARGB(159, 255, 255, 255),
                    label: 'User Id',
                    controller: userId,
                    icon: Icons.person,
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  CustomPasswardField(
                    color: const Color.fromARGB(159, 255, 255, 255),
                    label: 'Passward',
                    controller: passward,
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  loading
                      ? const SizedBox(
                          height: 50,
                          width: 50,
                          child: CircularProgressIndicator())
                      : SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                login();
                              }
                              // print(passward.text);
                            },
                            child: const Text(
                              'Log In',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 42, 125, 219),
                                  fontSize: 17),
                            ),
                          ),
                        ),
                  Row(
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.replace(
                              context,
                              oldRoute: ModalRoute.of(context)!,
                              newRoute: MaterialPageRoute(
                                  builder: (context) => const Register()),
                            );
                          },
                          child: const Text('Click here',
                              style: TextStyle(
                                fontSize: 17,
                              ))),
                      const Text(
                        'to register',
                        style: TextStyle(
                            color: Color.fromARGB(255, 31, 60, 133),
                            fontSize: 17),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
