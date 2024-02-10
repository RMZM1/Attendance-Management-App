import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../global/global.dart';
import '../userScreens/home.dart';
import '../widgets/loadingWidget.dart';
import 'register.dart';
import '../global/style.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var userLoginEmailCtrl = TextEditingController();
  var userLoginPasswordCtrl = TextEditingController();
  var passwordHidden = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeBackgroundColor,
        foregroundColor: themeForegroundColor,
        title: Center(
            child: Text(
          "AMS",
          style: appBarText(),
        )),
        automaticallyImplyLeading: false, // this will hide Drawer hamburger icon
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Heading
            Container(
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.all(10.0),
              child: Text(
                "Login",
                style: screenHeadingText(),
              ),
            ),
            //Input Fields
            Container(
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  //Email Field
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: userLoginEmailCtrl,
                      keyboardType: TextInputType.emailAddress,
                      decoration: textFieldsDec().copyWith(hintText: "Email"),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return "Email can't be empty";
                        }

                        if (EmailValidator.validate(text) == true) {
                          return null;
                        }
                        if (text.length < 2) {
                          return "Please enter a valid email";
                        }
                        if (text.length > 99) {
                          return "Email can't be more than 100";
                        }
                      },
                    ),
                  ),
                  //Password Field
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                        controller: userLoginPasswordCtrl,
                        keyboardType: TextInputType.text,
                        obscureText: passwordHidden,
                        obscuringCharacter: "*",
                        decoration: textFieldsDec().copyWith(
                          hintText: "Password",
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                if (passwordHidden == false) {
                                  passwordHidden = true;
                                } else {
                                  passwordHidden = false;
                                }
                              });
                            },
                            icon: passwordHidden
                                ?  Icon(MdiIcons.eye)
                                :  Icon(MdiIcons.eyeOff),
                            color: themeBackgroundColor,
                          ),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'Password can\'t be empty';
                          }
                          if (text.length < 8) {
                            return "Please enter a valid password";
                          }
                        }),
                  ),
                ],
              ),
            ),

            //Login Button
            Container(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  validateUserLoginForm();
                },
                style: actionBtnWithThemeColor(),
                child: Text(
                  "Login",
                  style: buttonThemeColorText(),
                ),
              ),
            ),

            //Don't Have an account? Signup
            Container(
              padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't Have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Register()));
                    },
                    child: const Text(
                      "Register",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void validateUserLoginForm() {
    if (userLoginEmailCtrl.text.isEmpty || userLoginPasswordCtrl.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "Please Fill All the fields",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (!userLoginEmailCtrl.text.contains("@")) {
      Fluttertoast.showToast(
          msg: "Email is not valid",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (userLoginPasswordCtrl.text.length < 8) {
      Fluttertoast.showToast(
          msg: "Password must be at least 8 Characters",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      loginUser();
    }
  }

  loginUser() async {
    showDialog(
        context: context,
        barrierDismissible: false, //it should not disappear on user click
        builder: (BuildContext context) {
          return const LoadingWidget();
        });

    await fAuth
        .signInWithEmailAndPassword(
            email: userLoginEmailCtrl.text.trim(),
            password: userLoginPasswordCtrl.text.trim())
        .then((auth) async {
      final User? firebaseUser = auth.user;
      if (firebaseUser != null) {
        currentUser = firebaseUser;
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
      } else {
        Navigator.pop(context);
        Fluttertoast.showToast(
            msg: "Something Went Wrong Please Try again later",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }).catchError((error) {
      Navigator.pop(context);
      String errorMessage = error.toString();
      String toastMessage;
      if (errorMessage.contains('user-not-found')) {
        toastMessage = 'No user record found';
      } else if (errorMessage.contains('network-error')) {
        toastMessage = 'Network error occurred';
      } else {
        toastMessage = 'An error occurred';
      }
      Fluttertoast.showToast(
          msg: toastMessage,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    });
  }

  moveToUserHome(){
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const UserHome()));
  }
  moveToLogin(){
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const Login()));
  }


}
