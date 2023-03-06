import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive_using/utils/constants.dart';
import 'package:hive_using/widgets/button.dart';
import 'package:hive_using/widgets/text_field.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late FirebaseAuth _firebaseAuth;
  final TextEditingController _userNameTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  bool _checkBoxState = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firebaseAuth = FirebaseAuth.instance;
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
                    labelText: kUsernameText,
                    textInputType: TextInputType.text),

                CustomTextField(
                    textEditingController: _emailTextController,
                    labelText: kEmailText,
                    textInputType: TextInputType.emailAddress),
                CustomTextField(
                    obscureText: true,
                    textEditingController: _passwordTextController,
                    labelText: kPasswordText,
                    textInputType: TextInputType.text),
                _acceptingTermsAndConditions(),
                const SizedBox(
                  height: 30,
                ),
                //Just sign up
                CustomButton(
                    callback: () {
                      _registerUser();
                    },
                    buttonText: kSignUpButtonText,
                    backgroundColor: kSignUpButtonColor),
                //Sign up with phone number
                CustomButton(
                    callback: () {
                      Navigator.of(context)
                          .pushNamed(kSignUpWithPhoneNumberScreen);
                    },
                    buttonText: kSignUpWithPhoneNumberButtonText,
                    backgroundColor: kMainAppColor),
                //Sign up with google account
                CustomButton(
                    foregroundColor: kMainAppColor,
                    callback: () {
                      _registerWithGoogleAccount();
                    },
                    buttonText: kSignUpWithGoogleAccountButtonText,
                    imagePath: kGoogleIconPath,
                    backgroundColor: Colors.white),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(kAlreadyHveAccountText,
                        style: appTextStyle(14, FontWeight.normal)),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          kSignUpButtonText,
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

  Widget _acceptingTermsAndConditions() {
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

  void _registerUser() async {
    if (_emailTextController.text.isNotEmpty &&
        _passwordTextController.text.isNotEmpty &&
        _userNameTextController.text.isNotEmpty &&
        _checkBoxState == true) {
      try {
        final userCredential =
            await _firebaseAuth.createUserWithEmailAndPassword(
                email: _emailTextController.text,
                password: _passwordTextController.text);
        final user = userCredential.user;
        if (user != null) {
          if (user.emailVerified) {
            if (mounted) {
              Navigator.of(context)
                  .pushReplacementNamed('/home', arguments: userCredential);
            }
          } else {
            await user.sendEmailVerification();
            if (mounted) {
              showCustomSnackBar(
                'We sent email verification link,please verify for sign up',
                context,
                kMainAppColor,
              );
            }
          }
        }
      } on FirebaseAuthException catch (e) {
        debugPrint(e.toString());
      }
    } else {
      showCustomSnackBar(
        'Please provide following details for your new account',
        context,
        Colors.redAccent,
      );
    }
  }

//TODO Should fix this bug,user can sign up if he once Signed up
  Future<void> _registerWithGoogleAccount() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    var user = await FirebaseAuth.instance.signInWithCredential(credential);
    if (user.user != null) {
      if (mounted) {
        Navigator.of(context).pushReplacementNamed(kHomeScreen);
      }
    }
  }
}
