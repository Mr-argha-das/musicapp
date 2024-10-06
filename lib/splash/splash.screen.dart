import 'dart:developer';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:musicproject/config/pretty.dio.dart';
import 'package:musicproject/config/userstorage/usersavedata.dart';
import 'package:musicproject/home/views/home.page.dart';
import 'package:musicproject/selectSinger/views/selectsinger.dart';
import 'package:musicproject/splash/model/login.model.dart';
import 'package:musicproject/splash/model/login.res.dart';
import 'package:musicproject/splash/service/login.service.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  bool isExapnded = false;
  bool showText = false;
  bool _isLoading = false;
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
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Sign in with Google
  Future<User?> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        // User cancelled the sign-in process
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      return user;
    } catch (error) {
      log(error.toString());
      print(error);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final userSavedata = ref.watch(userProvider);
    final userController = ref.watch(userProvider.notifier);
    if (userSavedata != null) {
      Future.delayed(Duration(seconds: 10), () {
        Navigator.pushAndRemoveUntil(
            context,
            CupertinoPageRoute(builder: (context) => const HomePage()),
            (routet) => false);
      });
    }
    return Scaffold(
      backgroundColor: Colors.black,
      body: _isLoading == true
          ? Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                  color: Colors.white, size: 40),
            )
          : SizedBox(
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
                  if (userSavedata != null) ...[
                    if (showText == true)
                      Center(
                          child: AnimatedTextKit(
                        animatedTexts: [
                          TyperAnimatedText(
                            'SRROUND...',
                            textStyle: GoogleFonts.heebo(
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            speed: const Duration(
                                milliseconds:
                                    300), // Control the speed of each character appearing
                          ),
                        ],
                        totalRepeatCount: 1, // Adjust how many times it repeats
                        pause: Duration(milliseconds: 250),
                        displayFullTextOnTap: true,
                        stopPauseOnTap: true,
                      )),
                  ],
                  if (userSavedata == null)
                    AnimatedContainer(
                      duration: const Duration(seconds: 2),
                      height: showText ? 300 : 0,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: Colors.black,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 40,
                            ),
                            Text(
                              "LOG IN SURROUND",
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: GestureDetector(
                                onTap: () async {
                                  User? user = await _signInWithGoogle();
                                  log(user!.displayName.toString());
                                  final service = LoginService(createDio());
                                  if (user != null) {
                                    try {
                                      LoginModelResponse res =
                                          await service.login(LoginModelBody(
                                              identifyer: user!.email!,
                                              name: user.displayName!,
                                              mailorphone: user.email!));
                                      setState(() {
                                        _isLoading = true;
                                      });

                                      if (res.message == "User Login succes") {
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            CupertinoPageRoute(
                                                builder: (context) =>
                                                    const HomePage()),
                                            (routet) => false);
                                        userController.saveUser(UserModel(
                                            id: res.data[0].id.oid,
                                            username: res.data[0].name,
                                            emailorphone:
                                                res.data[0].identifyer,
                                            image: " null ",
                                            loginby: "Google"));
                                      }
                                      if (res.message == "User create succes") {
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            CupertinoPageRoute(
                                                builder: (context) =>
                                                    const SelectSingerPage()),
                                            (routet) => false);

                                        userController.saveUser(UserModel(
                                            id: res.data[0].id.oid,
                                            username: res.data[0].name,
                                            emailorphone:
                                                res.data[0].identifyer,
                                            image: " null ",
                                            loginby: "Google"));
                                      }
                                    } catch (e) {}
                                  }
                                  if (user != null) {
                                    print(
                                        "User signed in: ${user.displayName}");
                                  }
                                },
                                child: Container(
                                  height: 60,
                                  width: 350,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.white, width: 1),
                                      borderRadius:
                                          BorderRadius.circular(5000)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.asset(
                                          "assets/googlelogi-removebg-preview.png",
                                          scale: 15,
                                        ),
                                      ),
                                      new SizedBox(
                                        width: 78,
                                      ),
                                      Center(
                                        child: Text(
                                          "Google",
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.montserrat(
                                              color: Colors.black,
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                height: 60,
                                width: 350,
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border: Border.all(
                                        color: Colors.white, width: 1),
                                    borderRadius: BorderRadius.circular(5000)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset(
                                        "assets/facebooklogo.png",
                                        scale: 1,
                                      ),
                                    ),
                                    new SizedBox(
                                      width: 70,
                                    ),
                                    Center(
                                      child: Text(
                                        "FaceBook",
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.montserrat(
                                            color: Colors.white,
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                ],
              ),
            ),
    );
  }
}
