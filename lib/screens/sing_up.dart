import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive_using/utils/constants.dart';
import 'package:hive_using/widgets/button.dart';
import 'package:hive_using/widgets/text_field.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late  FirebaseAuth _firebaseAuth;
  final TextEditingController _userNameTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  bool _checkBoxState = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 120,
                ),
                Text(
                  kSignUpPageTitleText,
                  textAlign: TextAlign.center,
                  style: appTextStyle(
                    35,
                    FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  kSignUpPageSubTitleText,
                  textAlign: TextAlign.center,
                  style: appTextStyle(15, FontWeight.normal),
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomTextField(
                    textEditingController: _userNameTextController,
                    labelText: 'Username',
                    textInputType: TextInputType.text),
                CustomTextField(
                    textEditingController: _emailTextController,
                    labelText: 'Email',
                    textInputType: TextInputType.emailAddress),
                CustomTextField(
                    obscureText: true,
                    textEditingController: _passwordTextController,
                    labelText: 'Password',
                    textInputType: TextInputType.text),
                _acceptingTermsAndConditions(),
                const SizedBox(
                  height: 30,
                ),
                CustomButton(
                    callback: () {
                      if (_checkBoxState == true) {
                        debugPrint('with phone number');
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                                'You are not confirmed terms and conditions')));
                      }
                    },
                    buttonText: 'Sign Up',
                    color: kSignUpButtonColor),
                CustomButton(
                    callback: () {
                      if (_checkBoxState == true) {

                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                                'You are not confirmed terms and conditions')));
                      }
                    },
                    buttonText: 'Sign Up with phone number',
                    color: kMainAppColor),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account?',
                        style: appTextStyle(14, FontWeight.normal)),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          'Sign In',
                          style: appTextStyle(16, FontWeight.bold),
                        ))
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  _acceptingTermsAndConditions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Transform.scale(
            scale: 1.4,
            child: Checkbox(
                fillColor: const MaterialStatePropertyAll(kMainAppColor),
                overlayColor: MaterialStateProperty.all(kMainAppColor),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
                value: _checkBoxState,
                onChanged: (newValue) {
                  if (newValue != null) {
                    setState(() {
                      _checkBoxState = newValue;
                    });
                  }
                }),
          ),
          Text(
            kSignUpPageTermsAndConditionsText,
            style: appTextStyle(14, FontWeight.normal, opasity: 0.1),
          )
        ],
      ),
    );
  }
}
