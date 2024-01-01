import 'package:flutter/material.dart';

class CustomNewTextFiled extends StatefulWidget {
  CustomNewTextFiled(
      {super.key,
      this.mainFontSize,
      this.fontSize,
      required this.controller,
      this.keyboardType,
      this.hintText});
  TextEditingController controller = TextEditingController();
  String? hintText;
  double? fontSize;
  double? mainFontSize;
  TextInputType? keyboardType;

  @override
  State<CustomNewTextFiled> createState() => _CustomNewTextFiledState();
}

class _CustomNewTextFiledState extends State<CustomNewTextFiled> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      style: TextStyle(color: Colors.black, fontSize: widget.mainFontSize),
      keyboardType: widget.keyboardType,
      maxLines: null,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: widget.hintText,
        hintStyle: TextStyle(color: Colors.grey, fontSize: widget.fontSize),
      ),
    );
  }
}
