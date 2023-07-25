import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_stock_log/screens/login.dart';
import 'package:my_stock_log/services/user_service.dart';
import 'package:my_stock_log/widgets/TextField.dart';

class Register extends StatefulWidget {
  const Register({super.key});
  @override
  State<Register> createState() {
    return _RegisterScreenState();
  }
}

class _RegisterScreenState extends State<Register> {
  register() async {
    setState(() {
      loading = true;
    });

    try {
      var response = await userRegister(
        json.encode(
          {
            'name': username.text.trim(),
            'email': email.text.trim(),
            'password': passward.text
          },
        ),
      );

      if (response.statusCode == 200) {
        print(response.body);
        ScaffoldMessenger.of(context).clearSnackBars();
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 3),
            content: const Center(
              child: Text('Registration Successfull.'),
            ),
            action: SnackBarAction(label: '', onPressed: () {}),
          ),
        );

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => const Login(),
          ),
        );
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

  var loading = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController passward = TextEditingController();
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
                    label: 'User Name',
                    controller: username,
                    icon: Icons.person,
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  CustomTextField(
                      color: const Color.fromARGB(159, 255, 255, 255),
                      label: 'Email',
                      controller: email,
                      icon: Icons.email),
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
                                register();
                              }
                              // print(passward.text);
                            },
                            child: const Text(
                              'Register',
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
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) => const Login(),
                              ),
                            );
                          },
                          child: const Text('Click here',
                              style: TextStyle(
                                fontSize: 17,
                              ))),
                      const Text(
                        'to login',
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
