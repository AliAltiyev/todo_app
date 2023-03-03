import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//Sign Up page
TextStyle appTextStyle(double fontSize, FontWeight fontWeight,
    {double? opasity, Color? color}) {
  return GoogleFonts.dmSans(
      fontWeight: fontWeight, fontSize: fontSize, color: color);
}

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
