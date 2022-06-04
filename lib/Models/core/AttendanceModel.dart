import 'package:intl/intl.dart';

class AttendanceModel {
  DateTime date;
  String endDate;
  String status;

  AttendanceModel(
      {required this.date, required this.endDate, required this.status});

  factory AttendanceModel.fromMap(Map<String, dynamic> j) {
    return AttendanceModel(
        date: DateTime.parse(j['startTime']),
        status: j['type'],
        endDate: j['endTime'] == null
            ? '-'
            : DateFormat('hh:mm aa').format(DateTime.parse(j['endTime'])));
  }
}
