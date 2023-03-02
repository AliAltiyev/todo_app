import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//Home page
final kAppBarTitleStyle = GoogleFonts.andika(
    textStyle:
        const TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.w800));
final kAppBArTitleText = 'appBarTitle'.tr();

//Hive - locale storage
const boxName = 'tasks';
