import 'package:flutter/material.dart';

class FormInputField extends StatelessWidget {
  final TextEditingController _controller;
  final String hintText;
  final String ValidateMessage;
  final TextInputType KeyboardType;
  const FormInputField(
      {Key? key,
      required TextEditingController itemController,
      required this.hintText,
      required this.ValidateMessage,
      required this.KeyboardType})
      : _controller = itemController,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        showCursor: true,
        style: TextStyle(
          color: Colors.purple,
          fontSize: 20,
        ),
        controller: _controller,
        keyboardType: KeyboardType,
        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          suffixIcon: IconButton(
            icon: Icon(Icons.clear),
            onPressed: () => _controller.clear(),
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return ValidateMessage;
          }
          return null;
        });
  }
}
