import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:musicproject/home/views/home.page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isExapnded = false;
  bool showText = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isExpanded();
  }

  _isExpanded() {
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        isExapnded = true;
      });
    });
    Future.delayed(Duration(seconds: 6), () {
      setState(() {
        showText = true;
      });
    });
    Future.delayed(Duration(seconds: 10), () {
      Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context) => const HomePage()), (routet) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedContainer(
              height: isExapnded ? 250 : 0,
              width: isExapnded ? 250 : 0,
              duration: const Duration(seconds: 5),
              decoration: const BoxDecoration(
                  color: Colors.black,
                  image: DecorationImage(
                      fit: BoxFit.contain,
                      image: AssetImage("assets/circle.gif"))),
            ),
            const SizedBox(
              height: 10,
            ),
            if (showText == true)
              Center(
                  child: AnimatedTextKit(
                animatedTexts: [
                  TyperAnimatedText(
                    'SRROUND...',
                    textStyle: GoogleFonts.montserrat(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    speed: Duration(
                        milliseconds:
                            300), // Control the speed of each character appearing
                  ),
                ],
                totalRepeatCount: 1, // Adjust how many times it repeats
                pause: Duration(milliseconds: 250),
                displayFullTextOnTap: true,
                stopPauseOnTap: true,
              ))
          ],
        ),
      ),
    );
  }
}
