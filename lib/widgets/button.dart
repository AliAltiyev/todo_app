import 'package:flutter/material.dart';
import 'package:hive_using/utils/constants.dart';

class CustomButton extends StatefulWidget {
  final VoidCallback callback;
  final String buttonText;
  final Color color;

  const CustomButton(
      {Key? key,
      required this.callback,
      required this.buttonText,
      required this.color})
      : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ElevatedButton(
        onPressed: widget.callback,
        style: ButtonStyle(
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16))),
            fixedSize: const MaterialStatePropertyAll(Size(340, 70)),
            foregroundColor: const MaterialStatePropertyAll(Colors.white),
            backgroundColor: MaterialStatePropertyAll(widget.color)),
        child: Text(
          widget.buttonText,
          style: appTextStyle(20, FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
