import 'package:amsuserpanel/model/userModel.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../global/global.dart';
import '../global/style.dart';
import '../widgets/loadingWidget.dart';
import 'login.dart';


class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var userRegNameCtrl = TextEditingController();
  var userRegEmailCtrl = TextEditingController();
  var userRegPasswordCtrl = TextEditingController();
  var userRegCPasswordCtrl = TextEditingController();
  var passwordHidden = true;
  var cPasswordHidden = true;

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
                "Register",
                style: screenHeadingText(),
              ),
            ),
            //Input Fields
            Container(
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: Column(
                children: [
                  //Name Field
                  Expanded(
                    flex: 0,
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: userRegNameCtrl,
                        keyboardType: TextInputType.text,
                        inputFormatters: [
                          // only accept letters from a to z
                          FilteringTextInputFormatter(RegExp(r'[a-zA-Z, ]'),
                              allow: true)
                        ],
                        maxLength: 15,
                        decoration: textFieldsDec().copyWith(hintText: "Name"),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'Name can\'t be empty';
                          }
                          if (text.length < 2) {
                            return "Please enter a valid name";
                          }
                        },
                      ),
                    ),
                  ),
                  //Email Field
                  Expanded(
                    flex: 0,
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: userRegEmailCtrl,
                        keyboardType: TextInputType.emailAddress,
                        decoration: textFieldsDec().copyWith(hintText: "Email"),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'Email can\'t be empty';
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
                  ),

                  //Password Field
                  Expanded(
                    flex: 0,
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                          controller: userRegPasswordCtrl,
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
                                  ? Icon(MdiIcons.eye)
                                  : Icon(MdiIcons.eyeOff),
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
                  ),
                  //Confirm Password Field
                  Expanded(
                    flex: 0,
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                          controller: userRegCPasswordCtrl,
                          keyboardType: TextInputType.text,
                          obscureText: cPasswordHidden,
                          obscuringCharacter: "*",
                          decoration: textFieldsDec().copyWith(
                            hintText: "Confirm Password",
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  if (cPasswordHidden == false) {
                                    cPasswordHidden = true;
                                  } else {
                                    cPasswordHidden = false;
                                  }
                                });
                              },
                              icon: cPasswordHidden
                                  ? Icon(MdiIcons.eye)
                                  : Icon(MdiIcons.eyeOff),
                              color: themeBackgroundColor,
                            ),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'Password can\'t be empty';
                            }
                            if (text != userRegPasswordCtrl.text) {
                              return "Password do not match";
                            }
                            if (text.length < 8) {
                              return "Please enter a valid password";
                            }
                          }),
                    ),
                  ),
                ],
              ),
            ),
            //Register Button
            Container(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  validateUserRegForm();
                },
                style: actionBtnWithThemeColor(),
                child: Text(
                  "Register",
                  style: buttonThemeColorText(),
                ),
              ),
            ),

            //Already Have an account? Login
            Container(
              padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already Have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Login()));
                    },
                    child: const Text(
                      "Login",
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

  void validateUserRegForm() {
    if (userRegNameCtrl.text.isEmpty ||
        userRegEmailCtrl.text.isEmpty ||
        userRegPasswordCtrl.text.isEmpty ||
        userRegCPasswordCtrl.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "Please Fill All the fields",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (userRegNameCtrl.text.length < 3) {
      Fluttertoast.showToast(
          msg: "Name must contain 3 characters",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    //S means Character without space
    //D means characters that are not Digits
    else if (!RegExp(r'\D+\S+@\S+\.\S+').hasMatch(userRegEmailCtrl.text)) {
      Fluttertoast.showToast(
          msg: "Email is not valid",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (userRegPasswordCtrl.text.length < 8) {
      Fluttertoast.showToast(
          msg: "Password must be at least 8 Characters",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (userRegPasswordCtrl.text != userRegCPasswordCtrl.text) {
      Fluttertoast.showToast(
          msg: "Password are not matching",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      checkUserRegEmailAlreadyExist();
    }
  }

  Future<void> checkUserRegEmailAlreadyExist() async {
    showDialog(
        context: context,
        barrierDismissible: false, //it should not disappear on user click
        builder: (BuildContext context) {
          return const LoadingWidget();
        });
    var emailInUse =
        checkIfEmailAlreadyInUse(userRegEmailCtrl.text.trim().toString());
    //If Email is already registered than show error message
    if (await emailInUse) {
      () => Navigator.pop(context);
      Fluttertoast.showToast(
          msg: "Email Already Registered",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      register();
    }
  }

  Future<void> register() async {
    await fAuth
        .createUserWithEmailAndPassword(
            email: userRegEmailCtrl.text.trim(),
            password: userRegPasswordCtrl.text.trim())
        .then((auth) async {
      currentUser = auth.user;
      if (currentUser != null) {
        UserModel newUser = UserModel();
        newUser.id = currentUser!.uid;
        newUser.name = userRegNameCtrl.text.trim();
        newUser.email = userRegEmailCtrl.text.trim();
        newUser.profilePicture = "";
        newUser.markedAttendance = [];
        newUser.leaveRequests = [];

        Map userMap = newUser.toJson();
        //create an instance of the user in firebase
        DatabaseReference userRef = db.ref().child("users");
        userRef.child(currentUser!.uid).set(userMap);
      }
      () => Navigator.pop(context);
      await Fluttertoast.showToast(
          msg: "Successfully Registered",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: themeBackgroundColor,
          textColor: Colors.white,
          fontSize: 16.0);
      await moveToLoginScreen();
    }).catchError((errorMessage) {
      () => Navigator.pop(context);
      Fluttertoast.showToast(
          msg: "Error occurred",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    });
  }

  moveToLoginScreen() {
    Navigator.push(context, MaterialPageRoute(builder: (c) => const Login()));
  }
}
