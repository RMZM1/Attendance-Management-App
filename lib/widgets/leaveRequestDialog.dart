import 'package:amsuserpanel/global/style.dart';
import 'package:amsuserpanel/model/leaveModel.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../global/global.dart';
import 'loadingWidget.dart';

class LeaveRequestDialog extends StatefulWidget {
  const LeaveRequestDialog({super.key});

  @override
  State<LeaveRequestDialog> createState() => _LeaveRequestDialogState();
}

class _LeaveRequestDialogState extends State<LeaveRequestDialog> {
  String selectedButton = "One Day";
  // For Single Day
  DateTime selectedDate = DateTime.now();

  // For Multiple Day
  DateTime from = DateTime.now();
  DateTime to = DateTime.now();

  TextEditingController reasonOneDayLeaveCtrl = TextEditingController();
  TextEditingController reasonMoreThanOneDayLeaveCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(5),
          decoration: textButtonContainerDecoration(),
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.5,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Leave Request Heading
                Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      "Leave Request",
                      style: screenHeadingText(),
                    )),
                // Leave Options i.e One Day Or Multiple Days
                Container(
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: () {
                            selectedButton = "One Day";
                            setState(() {});
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: selectedButton == "One Day"
                                ? themeBackgroundColor
                                : Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(0), // <-- Radius
                            ),
                          ),
                          child: Text(
                            "One Day",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: selectedButton == "One Day"
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          )),
                      TextButton(
                          onPressed: () {
                            selectedButton = "More Than One Day";
                            setState(() {});
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: selectedButton == "More Than One Day"
                                ? themeBackgroundColor
                                : Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(0), // <-- Radius
                            ),
                          ),
                          child: Text(
                            "More Than One Day",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: selectedButton == "More Than One Day"
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          )),
                    ],
                  ),
                ),
                // For One Day
                Visibility(
                  visible: selectedButton == "One Day",
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                selectedDate = await selectDate(context);
                                setState(() {

                                });
                              },
                              child: Text(
                                'Select Date',
                                style: buttonReverseThemeColorText(),),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            // Display selected date
                            Text(
                              selectedDate!.toLocal().toString().substring(0, 10),
                              style: blackColorText(),),
                          ],
                        ),
                        const SizedBox(
                            height: 15),
                        TextFormField(
                          controller: reasonOneDayLeaveCtrl,
                          keyboardType: TextInputType.text,
                          decoration: textFieldsDec().copyWith(hintText: "Reason"),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'Reason can\'t be empty';
                            }
                          },
                        ),

                      ],
                    ),
                  ),
                ),
                // For Multiple Days
                Visibility(
                    visible: selectedButton == "More Than One Day",
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  from = await selectDate(context);
                                  setState(() {

                                  });
                                },
                                child: Text(
                                  'From',
                                  style: buttonReverseThemeColorText(),),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              // Display selected date
                              Text(
                                from!.toLocal().toString().substring(0, 10),
                                style: blackColorText(),),
                            ],
                          ),
                          const SizedBox(
                              height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  to = await selectDate(context);
                                  setState(() {

                                  });
                                },
                                child: Text(
                                  'To',
                                  style: buttonReverseThemeColorText(),),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              // Display selected date
                              Text(
                                to!.toLocal().toString().substring(0, 10),
                                style: blackColorText(),),
                            ],
                          ),
                          const SizedBox(
                              height: 15),
                          TextFormField(
                            controller: reasonMoreThanOneDayLeaveCtrl,
                            keyboardType: TextInputType.text,
                            decoration: textFieldsDec().copyWith(hintText: "Reason"),
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return 'Reason can\'t be empty';
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                ),
                //  Cancel, Request Buttons
                Container(
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: actionBtnWithRedColor(),
                          child: Text(
                            "Cancel",
                            style: buttonThemeColorText(),
                          )),
                      ElevatedButton(
                          onPressed: () {
                            validateLeaveRequest();
                          },
                          style: actionBtnWithThemeColor(),
                          child: Text(
                            "Send Request",
                            style: buttonThemeColorText(),
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<DateTime> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    return picked ?? DateTime.now();
  }

  void validateLeaveRequest() {
    if(selectedButton == "One Day"){
      validateLeaveRequestForOneDay();
    }
    else if(selectedButton == "More Than One Day"){
      validateLeaveRequestForMultipleDays();
    }

  }

  void validateLeaveRequestForOneDay() {
    if(reasonOneDayLeaveCtrl.text.toString().isEmpty){
      Fluttertoast.showToast(
          msg: "Reason Can't be Empty",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    else{
      sendLeaveRequestForOneDay();
    }
  }

  void validateLeaveRequestForMultipleDays() {
    DateTime fromDate = DateTime(from!.year, from!.month, from!.day);
    DateTime toDate = DateTime(to!.year, to!.month, to!.day);

    if(reasonMoreThanOneDayLeaveCtrl.text.toString().isEmpty){
      Fluttertoast.showToast(
          msg: "Reason Can't be Empty",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    else if(fromDate.isAtSameMomentAs(toDate)){
      Fluttertoast.showToast(
          msg: "Your From and To both Dates are same if you want One Day off Please Select One Day Leave",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    else{
      sendLeaveRequestForMultipleDay();
    }

  }

  Future<void> sendLeaveRequestForOneDay() async {

    LeaveModel leaveRequest = LeaveModel();
    leaveRequest.from = selectedDate;
    leaveRequest.to = selectedDate;
    leaveRequest.noOfDays = 1;
    leaveRequest.reason = reasonOneDayLeaveCtrl.text.trim().toString();
    currentUserData!.leaveRequests ??= [];
    currentUserData!.leaveRequests!.add(leaveRequest);

    await updateUserData();

  }
  Future<void> sendLeaveRequestForMultipleDay() async {
    LeaveModel leaveRequest = LeaveModel();
    leaveRequest.from = from;
    leaveRequest.to = to;
    leaveRequest.noOfDays = calculateDaysDifference(from, to);
    leaveRequest.reason = reasonMoreThanOneDayLeaveCtrl.text.trim().toString();
    currentUserData!.leaveRequests ??= [];
    currentUserData!.leaveRequests!.add(leaveRequest);
    await updateUserData();

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
    Navigator.pop(context);//loading widget
    Navigator.pop(context);//Leave Request Dialog
    await Fluttertoast.showToast(
        msg: "Leave Request Sent to Admin",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }


}
