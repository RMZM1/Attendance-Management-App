import 'package:amsuserpanel/global/global.dart';
import 'package:amsuserpanel/global/style.dart';
import 'package:amsuserpanel/userScreens/profile.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/navigationDrawer.dart';

class MarkedAttendance extends StatefulWidget {
  const MarkedAttendance({super.key});

  @override
  State<MarkedAttendance> createState() => _MarkedAttendanceState();
}

class _MarkedAttendanceState extends State<MarkedAttendance> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late List<DateTime> _daysInMonth;

  List<String> monthsList = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];
  String? selectedMonth;

  List<String> yearList = [
    "2010",
    "2011",
    "2012",
    "2013",
    "2014",
    "2015",
    "2016",
    "2017",
    "2018",
    "2019",
    "2020",
    "2021",
    "2022",
    "2023",
    "2024"
  ];
  String? selectedYear;

  @override
  void initState() {
    // Set selected month and year dynamically
    selectedMonth =
        DateFormat('MMM').format(DateTime(2023, DateTime.now().month));

    selectedYear = DateTime.now().year.toString();

    generateDaysInMonth();

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
        child: Column(
          children: [
            Text(
              "Marked Attendance",
              style: screenHeadingText(),
            ),
            const SizedBox(
              height: 25,
            ),
            // Drop Down For Month Year
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //   Month
                Flexible(
                  child: Container(
                    decoration: BoxDecoration(
                      //background color of dropdown button
                      color: themeBackgroundColor,
                      //border of dropdown button
                      border: Border.all(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: DropdownButton2<String>(
                        value: selectedMonth,
                        isExpanded: true,
                        style: simpleTextWithThemeColor(),
                        underline: Container(),
                        hint: Text(
                          "Month",
                          style: simpleTextWithThemeColor(),
                        ),
                        iconStyleData: IconStyleData(
                          icon: const Icon(
                            Icons.arrow_drop_down,
                          ),
                          iconSize: 32,
                          iconEnabledColor: themeForegroundColor,
                        ),
                        dropdownStyleData: DropdownStyleData(
                          maxHeight: 250,
                          width: 250,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.black87,
                          ),
                          elevation: 20,
                          offset: const Offset(40, 0),
                          scrollbarTheme: ScrollbarThemeData(
                            radius: const Radius.circular(40),
                            thickness: MaterialStateProperty.all<double>(10),
                            thumbVisibility:
                                MaterialStateProperty.all<bool>(true),
                          ),
                        ),
                        items: monthsList.map((vehicle) {
                          return DropdownMenuItem(
                            value: vehicle,
                            child: Text(
                              vehicle,
                            ),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            selectedMonth = newValue.toString();
                            generateDaysInMonth();
                          });
                        }),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                // Year
                Flexible(
                  child: Container(
                    decoration: BoxDecoration(
                      //background color of dropdown button
                      color: themeBackgroundColor,
                      //border of dropdown button
                      border: Border.all(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: DropdownButton2<String>(
                        value: selectedYear,
                        isExpanded: true,
                        style: simpleTextWithThemeColor(),
                        underline: Container(),
                        hint: Text(
                          "Year",
                          style: simpleTextWithThemeColor(),
                        ),
                        iconStyleData: IconStyleData(
                          icon: const Icon(
                            Icons.arrow_drop_down,
                          ),
                          iconSize: 32,
                          iconEnabledColor: themeForegroundColor,
                        ),
                        dropdownStyleData: DropdownStyleData(
                          maxHeight: 250,
                          width: 250,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.black87,
                          ),
                          elevation: 20,
                          offset: const Offset(40, 0),
                          scrollbarTheme: ScrollbarThemeData(
                            radius: const Radius.circular(40),
                            thickness: MaterialStateProperty.all<double>(10),
                            thumbVisibility:
                                MaterialStateProperty.all<bool>(true),
                          ),
                        ),
                        items: yearList.map((vehicle) {
                          return DropdownMenuItem(
                            value: vehicle,
                            child: Text(
                              vehicle,
                            ),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            selectedYear = newValue.toString();
                            generateDaysInMonth();
                          });
                        }),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Flexible(
                child: Text(
              "$selectedMonth-$selectedYear",
              style: buttonReverseThemeColorText(),
            )),
            const SizedBox(
              height: 10,
            ),
            // Days
            Flexible(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  crossAxisSpacing: 1.0,
                  mainAxisSpacing: 1.0,
                ),
                itemCount: _daysInMonth.length,
                itemBuilder: (context, index) {
                  final day = _daysInMonth[index];
                  final dayName = DateFormat('E')
                      .format(day); // Get the day name (e.g., Mon)
                  final date = day.day;
                  // Convert month and year string to a numeric representation
                  final monthYear = DateFormat("MMM-yyyy")
                      .parse("$selectedMonth-$selectedYear");
                  // Create DateTime object
                  DateTime dateTime =
                      DateTime(monthYear.year, monthYear.month, date);
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      color: hasSameDate(
                              currentUserData!.markedAttendance!, dateTime)
                          ? Colors.green
                          : Colors.transparent,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          dayName,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text("$date"),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void generateDaysInMonth() {
    final monthYear =
        DateFormat("MMM-yyyy").parse("$selectedMonth-$selectedYear");
    final firstDay = DateTime(monthYear.year, monthYear.month, 1);
    final lastDay = DateTime(monthYear.year, monthYear.month + 1, 0);

    _daysInMonth = List.generate(
      lastDay.day,
      (index) => firstDay.add(Duration(days: index)),
    );
    setState(() {});
  }
}
