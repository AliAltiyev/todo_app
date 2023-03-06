import 'package:flutter/material.dart';
import 'package:hive_using/utils/constants.dart';

class SignUpWithPhoneNumber extends StatefulWidget {
  const SignUpWithPhoneNumber({Key? key}) : super(key: key);

  @override
  State<SignUpWithPhoneNumber> createState() => _SignUpWithPhoneNumberState();
}

class _SignUpWithPhoneNumberState extends State<SignUpWithPhoneNumber> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              const SizedBox(height: 100),
              Text(
                kSignUpWithMobileNumberTitleText,
                style: appTextStyle(36, FontWeight.bold, color: kMainAppColor),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                kSignUpWithMobileNumberSubTitleText,
                style: appTextStyle(15, FontWeight.bold, color: kMainAppColor),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
