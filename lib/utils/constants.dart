import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//Application Navigation
const kSplashScreen = '/splash';
const kHomeScreen = '/home';
const kSignUpScreen = '/sign_up';
const kSignUpWithPhoneNumberScreen = '/sign_up_with_phone_number';

//Sign Up page
TextStyle appTextStyle(double fontSize, FontWeight fontWeight,
    {double? opasity, Color? color}) {
  return GoogleFonts.dmSans(
      fontWeight: fontWeight, fontSize: fontSize, color: color);
}

const kSignUpWithMobileNumberTitleText = 'Mobile Number';
const kSignUpWithMobileNumberSubTitleText =
    'Please enter your valid phone number. We will send you 4-digit code to verify account.';

const kMainAppColor = Color.fromRGBO(28, 25, 57, 1);

const kSignUpPageSubTitleText = """Please provide following
details for your new account""";

const kSignUpPageTitleText = 'Welcome';

const kSignUpPageTermsAndConditionsText =
    """By creating your account you have to agree 
with our Teams and Conditions. """;

//Home page
final kAppBarTitleStyle = GoogleFonts.andika(
    textStyle:
        const TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.w800));
final kAppBArTitleText = 'appBarTitle'.tr();

//Hive - locale storage
const boxName = 'tasks';

//Custom Widgets
const kSignUpButtonColor = Color.fromRGBO(113, 101, 227, 1);

const kSignUpButtonText = 'Sign up';
const kSignUpWithPhoneNumberButtonText = 'Sign up with phone number';
const kSignUpWithGoogleAccountButtonText = 'Sign up with Google';
const kAlreadyHveAccountText = 'Already have an account?';
const kPasswordText = 'Password';
const kUsernameText = 'Username';
const kEmailText = 'Email';
//ShortCuts
void showCustomSnackBar(String text, BuildContext context, Color color) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    showCloseIcon: true,
    elevation: 8,
    content: Text(text),
    backgroundColor: color,
  ));
}

//Images paths
const kGoogleIconPath = 'assets/images/google.svg';
