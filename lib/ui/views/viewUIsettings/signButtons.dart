
import 'package:flutter/material.dart';

class SignTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final bool isPassword;
  final TextEditingController controller;
  final Color anaYaziRengi;
  final Color borderColor;

  const SignTextField({
    Key? key,
    required this.labelText,
    required this.hintText,
    this.isPassword = false,
    required this.controller,
    required this.anaYaziRengi,
    required this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20 , right: 20 , top: 12, bottom:12 ),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        style: TextStyle(color: borderColor),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: anaYaziRengi),
          hintText: hintText,
          hintStyle: TextStyle(color: anaYaziRengi),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: borderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: borderColor),
          ),
        ),
      ),
    );
  }
}
