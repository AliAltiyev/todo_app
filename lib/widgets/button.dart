import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_using/utils/constants.dart';

class CustomButton extends StatefulWidget {
  final VoidCallback callback;
  final String buttonText;
  final Color backgroundColor;
  final String? imagePath;
  final Color? foregroundColor;

  const CustomButton(
      {Key? key,
      required this.callback,
      required this.buttonText,
      required this.backgroundColor,
      this.imagePath, this.foregroundColor})
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
            foregroundColor:  MaterialStatePropertyAll(widget.foregroundColor),
            backgroundColor: MaterialStatePropertyAll(widget.backgroundColor)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.imagePath != null)
              CircleAvatar(
                radius: 16,
                child: SvgPicture.asset(
                  widget.imagePath ?? '',
                ),
              )
            else
              const SizedBox(
                width: 0,
                height: 0,
              ),
            SizedBox(
              width: 10,
            ),
            Text(
              widget.buttonText,
              style: appTextStyle(18, FontWeight.bold, color: widget.foregroundColor),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
