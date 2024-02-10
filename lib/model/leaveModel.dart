class LeaveModel{
  DateTime? from;
  DateTime? to;
  int? noOfDays;
  String? reason;
  bool? isAccepted;

  LeaveModel({
    this.from,
    this.to,
    this.noOfDays,
    this.reason,
    this.isAccepted,
});


  Map<String, dynamic> toJson() {
    return {
      'from': from?.toIso8601String(),
      'to': to?.toIso8601String(),
      'noOfDays': noOfDays,
      'reason':reason,
      'isAccepted': isAccepted,
    };
  }

  // Method to convert JSON to Dart object
  static LeaveModel fromJson(Map<String, dynamic> json) {
    return LeaveModel(
      from: json['from'] != null ? DateTime.parse(json['from']) : null,
      to: json['to'] != null ? DateTime.parse(json['to']) : null,
      noOfDays: json['noOfDays'],
      reason: json['reason'],
      isAccepted: json['isAccepted'],
    );
  }


}