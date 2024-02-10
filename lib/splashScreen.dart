import 'dart:async';
import 'package:amsuserpanel/global/style.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'authScreens/login.dart';
import 'global/global.dart';
import 'userScreens/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {

  //Tween Animation
  late Animation animation;
  late Animation animation2;
  late AnimationController controller;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    animation = Tween(begin: 0.0, end: 1.0).animate(controller);
    animation2 = Tween(begin: 1.0, end: 0.0).animate(controller);
    controller.addListener(() {
      setState(() {});
    });
    controller.forward();
    // Repeat the animation indefinitely
    controller.repeat(reverse: true);
    goto();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeBackgroundColor,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedOpacity(
              opacity: animation2.value,
              duration: const Duration(seconds: 1),
              child: Text(
                "AMS",
                style: splashScreenTitleText(),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            AnimatedOpacity(
              opacity: animation.value,
              duration: const Duration(seconds: 1),
              child: Icon(
                MdiIcons.calendar,
                color: Colors.white,
                size: 150,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void goto() {
    Timer(const Duration(seconds: 3), () async {
        if (fAuth.currentUser != null) {
          //Set Current User
          currentUser = fAuth.currentUser;
          await readCurrentUserInfoFromDB();
          if(currentUserData != null){
            moveToUserHome();
          }
          else{
            fAuth.signOut();
            Fluttertoast.showToast(
                msg: "Something Went Wrong Please Try again later",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
            moveToLogin();
          }
          //  Move to User Home
        } else {
          //  Move to User Login
          moveToLogin();
        }
    });
  }

  moveToUserHome(){
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const UserHome()));
  }
  moveToLogin(){
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const Login()));
  }
}
