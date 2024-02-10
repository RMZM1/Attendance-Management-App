import 'package:flutter/material.dart';

import '../global/global.dart';
import '../global/style.dart';
import '../widgets/navigationDrawer.dart';
import 'profile.dart';

class ViewLeaves extends StatefulWidget {
  const ViewLeaves({super.key});

  @override
  State<ViewLeaves> createState() => _ViewLeavesState();
}

class _ViewLeavesState extends State<ViewLeaves> {
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
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.all(8.0),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Leave Requests",
              style: screenHeadingText(),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.13,
                  padding: const EdgeInsets.all(5),
                  decoration: leaveRequestTableBoxDecoration(),
                  child: Text(
                    "Sr.",
                    style: blackColorText(),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  padding: const EdgeInsets.all(5),
                  decoration: leaveRequestTableBoxDecoration(),
                  child: Text(
                    "From",
                    style: blackColorText(),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  padding: const EdgeInsets.all(5),
                  decoration: leaveRequestTableBoxDecoration(),
                  child: Text(
                    "To",
                    style: blackColorText(),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.13,
                  padding: const EdgeInsets.all(5),
                  decoration: leaveRequestTableBoxDecoration(),
                  child: Text(
                    "Days",
                    style: blackColorText(),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  padding: const EdgeInsets.all(5),
                  decoration: leaveRequestTableBoxDecoration(),
                  child: Text(
                    "Status",
                    style: blackColorText(),
                  ),
                ),
              ],
            ),
            (currentUserData!.leaveRequests!.isNotEmpty)
                ? Expanded(
                    child: ListView.builder(
                      itemCount: currentUserData!.leaveRequests!.length,
                      itemBuilder: (context, index) {
                        int monthFrom = currentUserData!.leaveRequests![index].from!.month;
                        int dayFrom = currentUserData!.leaveRequests![index].from!.day;
                        String yearFrom = currentUserData!.leaveRequests![index].from!.year.toString().substring(2,4);

                        int monthTo = currentUserData!.leaveRequests![index].to!.month;
                        int dayTo = currentUserData!.leaveRequests![index].to!.day;
                        String yearTo = currentUserData!.leaveRequests![index].to!.year.toString().substring(2,4);

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.13,
                              padding: const EdgeInsets.all(5),
                              decoration: leaveRequestTableBoxDecoration(),
                              child: Text(
                                "${index+1}.",
                                style: greyColorText(),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              padding: const EdgeInsets.all(5),
                              decoration: leaveRequestTableBoxDecoration(),
                              child: Text(
                                "$dayFrom-$monthFrom-$yearFrom",
                                style: greyColorText(),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              padding: const EdgeInsets.all(5),
                              decoration: leaveRequestTableBoxDecoration(),
                              child: Text(
                                "$dayTo-$monthTo-$yearTo",
                                style: greyColorText(),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.13,
                              padding: const EdgeInsets.all(5),
                              decoration: leaveRequestTableBoxDecoration(),
                              child: Text(
                                "${currentUserData!.leaveRequests![index].noOfDays}",
                                style: greyColorText(),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              padding: const EdgeInsets.all(5),
                              decoration: leaveRequestTableBoxDecoration(),
                              child: Text(
                                currentUserData!.leaveRequests![index].isAccepted == null
                                    ? "Pending"
                                    : currentUserData!.leaveRequests![index].isAccepted == true
                                          ? "Approved"
                                          : "Rejected",
                                style: greyColorText(),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  )
                : Expanded(
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        margin: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 300,
                          child: Text(
                            "No Leave Requests",
                            style: screenHeadingText(),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
