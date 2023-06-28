// ignore: file_names
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.color,
      required this.label,
      required this.controller});

  // ignore: prefer_typing_uninitialized_variables
  final color;
  // ignore: prefer_typing_uninitialized_variables
  final label;
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  @override
  Widget build(BuildContext context) {
    var _obscureText = false;
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your UserId';
        }
        // You can add more validation logic here if needed
        return null;
      },
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(color: Color.fromARGB(68, 143, 143, 143)),
          borderRadius: BorderRadius.circular(5.5),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(66, 122, 122, 122),
          ),
        ),
        prefixIcon: Icon(
          Icons.person,
          color: color,
        ),
        filled: true,
        fillColor: const Color.fromARGB(44, 255, 252, 253),
        labelText: label,
        labelStyle: TextStyle(color: color, fontSize: 17),
      ),
    );
  }
}

class CustomPasswardField extends StatefulWidget {
  const CustomPasswardField(
      {super.key,
      required this.color,
      required this.label,
      required this.controller});

  // ignore: prefer_typing_uninitialized_variables
  final color;
  // ignore: prefer_typing_uninitialized_variables
  final label;
  // ignore: prefer_typing_uninitialized_variables
  final controller;

  @override
  State<CustomPasswardField> createState() => _CustomPasswardFieldState();
}

class _CustomPasswardFieldState extends State<CustomPasswardField> {
  var _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _obscureText,
      controller: widget.controller,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your UserId';
        }
        // You can add more validation logic here if needed
        return null;
      },
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(color: Color.fromARGB(68, 143, 143, 143)),
          borderRadius: BorderRadius.circular(5.5),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(66, 122, 122, 122),
          ),
        ),
        prefixIcon: Icon(
          Icons.key,
          color: widget.color,
        ),
        filled: true,
        fillColor: const Color.fromARGB(44, 255, 252, 253),
        labelText: widget.label,
        labelStyle: TextStyle(color: widget.color, fontSize: 17),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText; // Toggle the value of _obscureText
            });
          },
          icon: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
            color: const Color.fromARGB(181, 200, 200, 200),
          ),
        ),
      ),
    );
  }
}


  // TextFormField(
  //                 style: TextStyle(color: Colors.white),
  //                 decoration: InputDecoration(
  //                   labelText: 'User Id',

  //                   filled: true, // Set to true to fill the background color
  //                   fillColor: Color.fromARGB(
  //                       96, 255, 255, 255), // Set the desired background color
  //                   border: OutlineInputBorder(
  //                     // Define the shape of the TextFormField
  //                     borderRadius:
  //                         BorderRadius.circular(20.0), // Set the border radius
  //                     borderSide: BorderSide.none, // Remove the border line
  //                   ),
  //                 ),
  //                 validator: (value) {
  //                   if (value!.isEmpty) {
  //                     return 'Please enter your UserId';
  //                   }
  //                   // You can add more validation logic here if needed
  //                   return null;
  //                 },
  //               ),
  //               const SizedBox(
  //                 height: 14,
  //               ),
  //               TextFormField(
  //                 style: TextStyle(color: Color.fromARGB(255, 42, 42, 42)),
  //                 decoration: InputDecoration(
  //                   icon: Icon(Icons.person),
  //                   hintText: 'What do people call you?',

  //                   labelText: 'Password',
  //                   floatingLabelBehavior: FloatingLabelBehavior.always,

  //                   filled: true, // Set to true to fill the background color
  //                   fillColor: Color.fromARGB(
  //                       96, 255, 255, 255), // Set the desired background color
  //                   border: OutlineInputBorder(
  //                     // Define the shape of the TextFormField
  //                     borderRadius:
  //                         BorderRadius.circular(20.0), // Set the border radius
  //                     borderSide: BorderSide.none, // Remove the border line
  //                   ),
  //                 ),
  //                 validator: (value) {
  //                   if (value!.isEmpty) {
  //                     return 'Please enter your UserId';
  //                   }
  //                   // You can add more validation logic here if needed
  //                   return null;
  //                 },
  //               ),