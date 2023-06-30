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
  var _enteredPrice = 0;
  DateTime? _selectedDate;
  String _selectedValue = 'Buy';

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
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // setState(() {
      //   _isSending = true;
      // });

      final response = await addStock(
          json.encode({
            "name": _enteredName,
            "price": _enteredPrice,
            "quantity": _enteredQuantity,
            "date": _selectedDate.toString(),
            "status": _selectedValue
          }),
          widget.token);

      print(response.body);
      // final Map<dynamic, dynamic> resData = json.decode(response.body);

      if (!context.mounted) {
        return;
      }
      Navigator.of(context).pop(
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
    }
  }

  @override
  void initState() {
    super.initState();
    options = widget.name;
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
                TextFormField(
                  maxLength: 50,
                  decoration: const InputDecoration(
                    label: Text('Name'),
                  ),
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
                ), // instead of TextField()
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
                              int.tryParse(value) == null ||
                              int.tryParse(value)! <= 0) {
                            return 'Must be a valid positive number.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _enteredPrice = int.parse(value!);
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(_selectedDate == null
                        ? 'No Date Selected'
                        : formatter.format(_selectedDate!)),
                    IconButton(
                        onPressed: _presentDatePicker,
                        icon: const Icon(Icons.calendar_month))
                  ],
                ),

                Column(
                  children: [
                    RadioListTile<String>(
                      title: Text('Buy'),
                      value: 'Buy',
                      groupValue: _selectedValue,
                      onChanged: (value) {
                        setState(() {
                          _selectedValue = value!;
                        });
                      },
                    ),
                    RadioListTile<String>(
                      title: Text('Sell'),
                      value: 'Sell',
                      groupValue: _selectedValue,
                      onChanged: (value) {
                        setState(() {
                          _selectedValue = value!;
                        });
                      },
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
                Autocomplete<String>(
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    if (textEditingValue.text.isEmpty) {
                      return const Iterable<String>.empty();
                    }
                    return options.where(
                        (option) => option.contains(textEditingValue.text));
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
                      controller: textEditingController,
                      focusNode: focusNode,
                      onFieldSubmitted: (value) {
                        onFieldSubmitted();
                      },
                      decoration: InputDecoration(
                        labelText: 'Select an option',
                      ),
                    );
                  },

                  //             optionsViewBuilder: (BuildContext context, AutocompleteOnSelected<String> onSelected) {
                  //   return ListView.builder(
                  //     itemCount: options.length,
                  //     itemBuilder: (BuildContext context, int index) {
                  //       final String option = options[index];
                  //       return ListTile(
                  //         title: Text(option),
                  //         onTap: () {
                  //           onSelected(option);
                  //         },
                  //       );
                  //     },
                  //   );
                  // },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
