import 'package:amsuserpanel/userScreens/profile.dart';
import 'package:flutter/material.dart';

import '../global/global.dart';
import '../global/style.dart';
import '../model/userModel.dart';
import '../splashScreen.dart';
import '../userScreens/home.dart';

class UserNavigationDrawer extends StatefulWidget {
  final UserModel? user;
  const UserNavigationDrawer({super.key, this.user});

  @override
  State<UserNavigationDrawer> createState() => _UserNavigationDrawerState();
}

class _UserNavigationDrawerState extends State<UserNavigationDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: themeBackgroundColor,
      child: ListView(
        children: [
          //  Drawer Header
          Container(
            height: 180,
            color: themeBackgroundColor,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: themeForegroundColor,
                border: Border.all(color: Colors.white, width: 1),
              ),
              child: Row(
                children: [
                  currentUserData!.profilePicture == null
                      ? Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Icon(
                            Icons.person,
                            color: themeBackgroundColor,
                            size: 70,
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Material(
                            shape: const CircleBorder(),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: InkWell(
                              onTap: () {},
                              child: Ink.image(
                                image: NetworkImage(
                                    "${currentUserData!.profilePicture}"),
                                height: 70,
                                width: 70,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: 150,
                          child: Text(
                              widget.user != null
                                  ? widget.user!.name != null
                                      ? "${widget.user!.name}"
                                      : "UserName"
                                  : "UserName",
                              style: buttonReverseThemeColorText()),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          width: 150,
                          child: Text(
                              widget.user != null
                                  ? widget.user!.email != null
                                      ? "${widget.user!.email}"
                                      : "UserEmail"
                                  : "UserEmail",
                              textAlign: TextAlign.left,
                              style: simpleTextWithReverseThemeColor()),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Divider
          const Divider(
            height: 1,
            thickness: 12,
            color: Colors.blueGrey,
          ),

          //  Drawer Body
          //Home
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UserHome(),
                  ));
            },
            child: ListTile(
              leading: Icon(
                Icons.home,
                color: themeForegroundColor,
              ),
              title: Text("Home", style: buttonThemeColorText()),
            ),
          ),
          //Profile
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UserProfile(),
                  ));
            },
            child: ListTile(
              leading: Icon(
                Icons.person,
                color: themeForegroundColor,
              ),
              title: Text("Profile", style: buttonThemeColorText()),
            ),
          ),

          //Sign out
          GestureDetector(
            onTap: () {
              signOut();
            },
            child: ListTile(
              leading: Icon(
                Icons.logout,
                color: themeForegroundColor,
              ),
              title: Text("Logout", style: buttonThemeColorText()),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> signOut() async {
    currentUserData = null;
    fAuth.signOut();
    moveToSplashScreen();
  }

  moveToSplashScreen() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        ));
  }
}
