import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:my_stock_log/services/user_service.dart';
import 'package:my_stock_log/widgets/log_inkwell.dart';

class NewItem extends StatefulWidget {
  const NewItem({super.key, required this.token, required this.name});
  final String token;
  final List<String> name;

  @override
  State<NewItem> createState() {
    return _NewItemState();
  }
}

class _NewItemState extends State<NewItem> {
  final _formKey = GlobalKey<FormState>();
  var _enteredName = '';
  var _enteredQuantity = 1;
  double _enteredPrice = 0;
  DateTime? _selectedDate;
  String _selectedValue = 'Buy';
  var newStock = {};

  var _isSending = false;
  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstdate = DateTime(now.year - 1, now.month, now.day);
    final lastDate = DateTime(now.year + 1, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstdate,
        lastDate: lastDate);

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  List<String> options = [];
  late String selectedOption;

  void _saveItem() async {
    if (_formKey.currentState!.validate() && _selectedDate != null) {
      _formKey.currentState!.save();
      setState(() {
        _isSending = true;
      });
      try {
        final response = await addStock(
            json.encode({
              "name": _enteredName,
              "price": _enteredPrice,
              "quantity": _enteredQuantity,
              "date": _selectedDate.toString(),
              "status": _selectedValue
            }),
            widget.token);
        if (response.statusCode == 200) {
          // print(response.body);
          newStock = json.decode(response.body);
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
          return;
        }
      } catch (error) {
        ScaffoldMessenger.of(context).clearSnackBars();
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 3),
            content: const Center(
              child: Text('Failed. Please try again later.'),
            ),
            action: SnackBarAction(label: '', onPressed: () {}),
          ),
        );
        return;
      }

      if (!context.mounted) {
        return;
      }
      setState(() {
        _isSending = true;
      });

      Navigator.of(context).pop(newStock

          // GroceryItem(
          //     id: resData['name'],
          //     name: _enteredName,
          //     quantity: _enteredQuantity,
          //     category: _selectedCategory),

          );

      // Navigator.of(context).pop(
      //   GroceryItem(
      //       id: DateTime.now().toString(),
      //       name: _enteredName,
      //       quantity: _enteredQuantity,
      //       category: _selectedCategory),
      // );
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid input'),
          content: const Text('Please make sure valid Inputs'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('okay'),
            ),
          ],
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    options = widget.name.toSet().toList();
    // print(options);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Autocomplete<String>(
                        optionsBuilder: (TextEditingValue textEditingValue) {
                          if (textEditingValue.text.isEmpty) {
                            return const Iterable<String>.empty();
                          }
                          return options.where((option) => option
                              .toLowerCase()
                              .contains(textEditingValue.text.toLowerCase()));
                        },
                        onSelected: (String value) {
                          setState(() {
                            selectedOption = value;
                          });
                        },
                        fieldViewBuilder: (BuildContext context,
                            TextEditingController textEditingController,
                            FocusNode focusNode,
                            VoidCallback onFieldSubmitted) {
                          return TextFormField(
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.trim().length == 1 ||
                                  value.trim().length > 50) {
                                return 'Must be between 1 and 50 characters.';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _enteredName = value!;
                            },
                            maxLength: 50,
                            controller: textEditingController,
                            focusNode: focusNode,
                            onFieldSubmitted: (value) {
                              onFieldSubmitted();
                            },
                            decoration: const InputDecoration(
                              label: Text('Stock Name'),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(_selectedDate == null
                        ? 'No Date Selected'
                        : formatter.format(_selectedDate!)),
                    IconButton(
                        onPressed: _presentDatePicker,
                        icon: const Icon(Icons.calendar_month))
                  ],
                ),
                // instead of TextField()
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          label: Text('Quantity'),
                        ),
                        initialValue: _enteredQuantity.toString(),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              int.tryParse(value) == null ||
                              int.tryParse(value)! <= 0) {
                            return 'Must be a valid positive number.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _enteredQuantity = int.parse(value!);
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          label: Text('Price'),
                        ),
                        initialValue: _enteredPrice.toString(),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              double.tryParse(value) == null ||
                              double.tryParse(value)! <= 0) {
                            return 'Must be a valid positive number.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _enteredPrice = double.parse(value!);
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),

                Row(
                  children: [
                    Expanded(
                      child: RadioListTile<String>(
                        title: const Text('Buy'),
                        value: 'Buy',
                        groupValue: _selectedValue,
                        onChanged: (value) {
                          setState(() {
                            _selectedValue = value!;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<String>(
                        title: const Text('Sell'),
                        value: 'Sell',
                        groupValue: _selectedValue,
                        onChanged: (value) {
                          setState(() {
                            _selectedValue = value!;
                          });
                        },
                      ),
                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: _isSending
                          ? null
                          : () {
                              _formKey.currentState!.reset();
                            },
                      child: const Text('Reset'),
                    ),
                    ElevatedButton(
                      onPressed: _isSending ? null : _saveItem,
                      child: _isSending
                          ? const SizedBox(
                              height: 16,
                              width: 16,
                              child: CircularProgressIndicator(),
                            )
                          : const Text('Add Item'),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
