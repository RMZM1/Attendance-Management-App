import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import '../global/global.dart';
import '../global/style.dart';
import '../splashScreen.dart';
import '../widgets/loadingWidget.dart';
import '../widgets/navigationDrawer.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var existingImageUrl;

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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30,
            ),
            currentUserData!.profilePicture == null
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                      elevation: 8,
                      shape: const CircleBorder(),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Stack(
                        children: [
                          InkWell(
                            onTap: () {
                              uploadImage();
                            },
                            child: Ink.image(
                              image:
                                  const AssetImage("assets/images/person.png"),
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                              bottom: 0,
                              child: SizedBox(
                                width: 100,
                                height: 100,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        uploadImage();
                                      },
                                      style: actionBtnWithThemeColor(),
                                      child: Text(
                                        "Edit",
                                        style: buttonThemeColorText(),
                                      ),
                                    )
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                      elevation: 8,
                      shape: const CircleBorder(),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Stack(
                        children: [
                          InkWell(
                            onTap: () {
                              uploadImage();
                            },
                            child: Ink.image(
                              image: NetworkImage(
                                  "${currentUserData!.profilePicture}"),
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                              bottom: 0,
                              child: SizedBox(
                                width: 100,
                                height: 100,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        uploadImage();
                                      },
                                      style: actionBtnWithThemeColor(),
                                      child: Text(
                                        "Edit",
                                        style: buttonThemeColorText(),
                                      ),
                                    )
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),

            //Name
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
              decoration: textButtonContainerDecoration(),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.person,
                      color: Color.fromRGBO(59, 59, 59, 1.0),
                      size: 32,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Name",
                          style: greyColorText(),
                        ),
                        Text(
                          "${currentUserData!.name}",
                          style: greyColorButtonText(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            //Email
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
              decoration: textButtonContainerDecoration(),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.email,
                      color: Color.fromRGBO(59, 59, 59, 1.0),
                      size: 32,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Email",
                          style: greyColorText(),
                        ),
                        Text(
                          "${currentUserData!.email}",
                          style: greyColorButtonText(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            //Logout Button
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
              decoration: textButtonContainerDecoration(),
              child: TextButton(
                onPressed: () {
                  currentUserData = null;
                  fAuth.signOut();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SplashScreen()));
                },
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.logout,
                        color: Color.fromRGBO(59, 59, 59, 1.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Logout",
                        style: greyColorButtonText(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  uploadImage() async {
    //Check whether there is a profile pic or not
    await retrieveExistingImageUrl();
    // Pick a new image
    final imagePath = await pickImage();
    if (imagePath == null) {
      return; // No image was selected
    }
    String uniqueFileName =
        "${currentUserData!.name}+${DateTime.now().microsecondsSinceEpoch.toString()}";
    //  Firebase Storage
    final storageReference = FirebaseStorage.instance
        .ref()
        .child('profilePics')
        .child(uniqueFileName);

    showDialog(
        context: context,
        barrierDismissible: false, //it should not disappear on user click
        builder: (BuildContext context) {
          return const LoadingWidget();
        });

    //First check that if there is already a profile pic if it is than delete and upload new

    try {
      final uploadTask = storageReference.putFile(File(imagePath));

      final snapshot = await uploadTask.whenComplete(() {});
      if (snapshot.state == TaskState.success) {
        final imageUrl = await snapshot.ref.getDownloadURL();
        final databaseReference = db
            .ref()
            .child('users')
            .child(currentUserData!.id!)
            .child('profilePicture');
        await databaseReference.set(imageUrl);

        //Delete Existing Profile Pic If exist
        if (existingImageUrl != null) {
          var existingStorageReference =
              FirebaseStorage.instance.refFromURL(existingImageUrl!);
          await existingStorageReference.delete();
        }

        // Success!
        Navigator.pop(context);
        await Fluttertoast.showToast(
            msg: "Image Uploaded Successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        await readCurrentUserInfoFromDB();
        setState(() {});
      }
      else {
        Navigator.pop(context);
        // Error occurred during image upload.
        await Fluttertoast.showToast(
            msg:
                "An Error occurred while uploading image please try Again later",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
    catch (err) {
      Navigator.pop(context);
      await Fluttertoast.showToast(
          msg: "Something went wrong",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  Future<String?> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      return pickedFile.path;
    }

    return null;
  }

  Future<void> retrieveExistingImageUrl() async {
    final databaseReference =
        db.ref().child('users').child(currentUserData!.id!).child('profilePicture');
    await databaseReference.once().then((data) {
      existingImageUrl = data.snapshot.value;
    });
  }
}
