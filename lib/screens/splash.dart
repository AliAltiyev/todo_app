import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _navigation();
  }

  _navigation() async {
    await Future.delayed(Duration(seconds: 3));
    Navigator.pushReplacementNamed(context, '/sign_up');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xff7165e3),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 89,
            top: 370,
            child: Align(
              child: SizedBox(
                width: 236,
                height: 92,
                child: Text(
                  'Task',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.dmSans(
                    fontSize: 70,
                    fontWeight: FontWeight.w700,
                    height: 1.3025,
                    letterSpacing: -2,
                    color: Color(0xffffffff),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            // bankfinancekitEFP (0:219)
            left: 130,
            top: 461,
            child: Align(
              child: SizedBox(
                width: 155,
                height: 29,
                child: Text(
                  'Make Your Life Easy',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.dmSans(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    height: 1.45,
                    color: Color(0xffffffff),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
