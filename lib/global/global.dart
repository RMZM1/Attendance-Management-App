import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import '../model/userModel.dart';

final FirebaseAuth fAuth = FirebaseAuth.instance;
final FirebaseDatabase db = FirebaseDatabase.instance;
User? currentUser;
UserModel? currentUserData;


Future<bool> checkIfEmailAlreadyInUse(String emailAddress) async {
  // Fetch sign-in methods for the email address
  final emailList = await fAuth.fetchSignInMethodsForEmail(emailAddress);

  // In case list is not empty
  if (emailList.isNotEmpty) {
    // Return true because there is an existing
    // user using the email address
    return true;
  } else {
    // Return false because email address is not in use
    return false;
  }
}
readCurrentUserInfoFromDB() async {
  currentUser = fAuth.currentUser;

  DatabaseReference userRef = db.ref().child("users").child(currentUser!.uid);

  await userRef.once().then((snap) {
    if (snap.snapshot.value != null) {
      currentUserData = UserModel.fromSnapshot(snap.snapshot);
    }
  });
}

bool hasSameDate(List<DateTime> dateTimes, DateTime specificDateTime) {
  // Extract the date part of the specific DateTime
  DateTime specificDate = DateTime(specificDateTime.year, specificDateTime.month, specificDateTime.day);

  // Check if the list contains a DateTime with the same date
  return dateTimes.any((dateTime) {
    DateTime currentDate = DateTime(dateTime.year, dateTime.month, dateTime.day);
    return currentDate == specificDate;
  });
}
int calculateDaysDifference(DateTime date1, DateTime date2) {
  // Calculate the difference between the two dates
  Duration difference = date2.difference(date1);

  // Extract the number of days from the duration
  int numberOfDays = difference.inDays + 1; // Adding 1 to include both dates

  return numberOfDays;
}
