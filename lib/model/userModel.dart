import 'package:amsuserpanel/model/leaveModel.dart';
import 'package:firebase_database/firebase_database.dart';

class UserModel {
  String? id;
  String? name;
  String? email;
  String? profilePicture;
  List<DateTime>? markedAttendance;
  List<LeaveModel>? leaveRequests;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.profilePicture,
    this.markedAttendance,
    this.leaveRequests,
  });

  UserModel.fromSnapshot(DataSnapshot snapshot) {
    id = snapshot.key;
    name = (snapshot.value as dynamic)['name'];
    email = (snapshot.value as dynamic)['email'];
    profilePicture = (snapshot.value as dynamic)['profilePicture'];
    // Convert the 'markedAttendance' list from dynamic to List<DateTime>
    markedAttendance = _convertDynamicListToDateTimeList((snapshot.value as dynamic)['markedAttendance']);
    // Convert the 'leaveRequests' list from dynamic to List<DateTime>
    leaveRequests = getLeaveRequests((snapshot.value as dynamic)['leaveRequests']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'profilePicture':profilePicture,
      'markedAttendance': _convertDateTimeListToJson(markedAttendance),
      'leaveRequests': _convertLeaveRequestListToJson(leaveRequests),
    };
  }

  // Helper method to convert List<DateTime> to List<String> (for JSON)
  List<String>? _convertDateTimeListToJson(List<DateTime>? dateTimes) {
    return dateTimes?.map((dateTime) => dateTime.toIso8601String()).toList();
  }
  // Helper method to convert List<String> (from JSON) to List<DateTime>
  List<DateTime>? _convertDynamicListToDateTimeList(dynamic dynamicList) {
    if (dynamicList == null) {
      return null;
    }
    return (dynamicList as List<dynamic>).map((dateString) => DateTime.parse(dateString)).toList();
  }


  // Helper method to convert a dynamic List to List<LeaveModel>
  static List<LeaveModel>? getLeaveRequests(dynamic leaves) {
    List<LeaveModel> tempList = [];
    if (leaves != null && leaves is List) {
      for(int i =0; i<leaves.length; i++){
        LeaveModel leave = LeaveModel();
        leave.from = leaves[i]["from"] != null ? DateTime.parse(leaves[i]['from']) : null;
        leave.to = leaves[i]["to"] != null ? DateTime.parse(leaves[i]['to']) : null;
        leave.noOfDays = leaves[i]["noOfDays"];
        leave.reason = leaves[i]["reason"];
        leave.isAccepted = leaves[i]["isAccepted"];
        tempList.add(leave);
      }

      return tempList;
    }
    return null;
  }
  // Helper method to convert a List<LeaveModel> to List<Map<String, dynamic>>
  static List<Map<String, dynamic>>? _convertLeaveRequestListToJson(List<LeaveModel>? leaves) {
    if (leaves != null) {
      return leaves.map((leave) => leave.toJson()).toList();
    }
    return null;
  }


}