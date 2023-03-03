import 'package:flutter/material.dart';
import 'package:hive_using/utils/constants.dart';

class CustomTextField extends StatefulWidget {
  TextEditingController textEditingController;
  final String labelText;
  final TextInputType textInputType;
  final bool? obscureText;

  CustomTextField(
      {Key? key,
      required this.textEditingController,
      required this.labelText,
      required this.textInputType,
      this.obscureText})
      : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 340,
      height: 60,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
        child: TextField(
          obscureText: widget.obscureText ?? false,
          onChanged: (String newValue) {
            widget.textEditingController.text = newValue;
            widget.textEditingController.selection = TextSelection.fromPosition(
                TextPosition(offset: widget.textEditingController.text.length));
          },
          textInputAction: TextInputAction.done,
          controller: widget.textEditingController,
          decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                      color: Color.fromRGBO(28, 25, 57, 1),
                      width: 2,
                      strokeAlign: 2)),
              labelText: widget.labelText,
              labelStyle: appTextStyle(18, FontWeight.normal),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(16))),
          keyboardType: widget.textInputType,
        ),
      ),
    );
  }
}
