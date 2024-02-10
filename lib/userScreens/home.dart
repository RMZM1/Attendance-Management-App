import 'package:amsuserpanel/userScreens/markedAttendance.dart';
import 'package:amsuserpanel/userScreens/profile.dart';
import 'package:amsuserpanel/userScreens/viewLeaves.dart';
import 'package:amsuserpanel/widgets/leaveRequestDialog.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../global/global.dart';
import '../global/style.dart';
import '../widgets/loadingWidget.dart';
import '../widgets/navigationDrawer.dart';

class UserHome extends StatefulWidget {
  const UserHome({super.key});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
      key: _scaffoldKey,
      drawer: UserNavigationDrawer(
        user: currentUserData,
      ),
      appBar: AppBar(
        backgroundColor: themeBackgroundColor,
        foregroundColor: themeForegroundColor,
        title: Center(
            child: Text(
          "AMS",
          style: appBarText(),
        )),
        actions: [
          currentUserData!.profilePicture == null
              ? TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const UserProfile()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.green,
                        width: 3.0,
                      ),
                    ),
                    child: Icon(
                      Icons.person,
                      size: 32,
                      color: themeForegroundColor,
                    ),
                  ))
              : TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const UserProfile()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.green,
                        width: 3.0,
                      ),
                    ),
                    child: CircleAvatar(
                      backgroundImage:
                          NetworkImage('${currentUserData!.profilePicture}'),
                    ),
                  ),
                ),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 50,
            ),
            // Mark Attendance Button
            ElevatedButton(
              onPressed: () {
                markAttendance();
              },
              style: actionBtnWithThemeColor(),
              child: Text(
                "Mark Attendance",
                style: buttonThemeColorText(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            // Request Leave Button
            ElevatedButton(
              onPressed: () {
                requestLeave();
              },
              style: actionBtnWithThemeColor(),
              child: Text(
                "Request Leave",
                style: buttonThemeColorText(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            // View Attendance Button
            ElevatedButton(
              onPressed: () {
                viewAttendance();
              },
              style: actionBtnWithThemeColor(),
              child: Text(
                "View Attendance",
                style: buttonThemeColorText(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            // View Leaves Button
            ElevatedButton(
              onPressed: () {
                viewLeaves();
              },
              style: actionBtnWithThemeColor(),
              child: Text(
                "View Leave Requests",
                style: buttonThemeColorText(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void markAttendance() {
    if (currentUser != null) {
      DateTime currentDate = DateTime.now();

      currentUserData!.markedAttendance ??= [];
      bool checkDateExist = hasSameDate(currentUserData!.markedAttendance!, currentDate);
      
      // Check if the currentDate is not already in the markedAttendance list
      if (checkDateExist == false) {
        // Add the currentDate to the markedAttendance list
        currentUserData!.markedAttendance!.add(currentDate);
        // Update the user data in the database
        updateUserData();
      }
      else {
        // Attendance already marked for today
        Fluttertoast.showToast(
            msg: "Attendance already marked for today",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
  }

  void requestLeave() {
    showDialog(
        context: context,
        barrierDismissible: false, //it should not disappear on user click
        builder: (BuildContext context) {
          return const LeaveRequestDialog();
        });
  }

  void viewAttendance() {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>const MarkedAttendance()));
  }

  void viewLeaves() {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>const ViewLeaves()));
  }

  Future<void> updateUserData() async {
    showDialog(
        context: context,
        barrierDismissible: false, //it should not disappear on user click
        builder: (BuildContext context) {
          return const LoadingWidget();
        });

    Map userMap = currentUserData!.toJson();
    DatabaseReference userRef = db.ref().child("users");
    await userRef.child(currentUser!.uid).set(userMap);
    await readCurrentUserInfoFromDB();
    Navigator.pop(context);
    await Fluttertoast.showToast(
        msg: "Attendance marked for ${DateTime.now().toLocal()}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }

}
