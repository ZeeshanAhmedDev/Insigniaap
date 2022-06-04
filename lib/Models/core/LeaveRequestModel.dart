class RequestModel {
  String id;
  String type;
  DateTime startDate;
  DateTime endDate;
  int days;
  String reason;
  String status;
  DateTime createAt;
  String documnet;

  RequestModel(
      {required this.id,
      required this.startDate,
      required this.endDate,
      required this.days,
      required this.type,
      required this.createAt,
      required this.documnet,
      required this.status,
      required this.reason});

  factory RequestModel.fromMap(Map<String, dynamic> j) {
    return RequestModel(
        id: j['_id'],
        type: j['type'],
        days: j['days'],
        status: j['status'],
        reason: j['reason'],
        documnet: j['document'],
        endDate: DateTime.parse(j['endDate']).add(const Duration(hours: 5)),
        startDate: DateTime.parse(j['startDate']).add(const Duration(hours: 5)),
        createAt: DateTime.parse(j['createAt']).add(const Duration(hours: 5)));
  }
}






// class RequestModel {
//   String type;
//   DateTime date;
//   int days;
//   String reason;
//   String status;

//   RequestModel(
//       {required this.date,
//       required this.days,
//       required this.type,
//       required this.status,
//       required this.reason});
// }

// List<RequestModel> requests = [
//   RequestModel(
//       type: "Sick",
//       days: 2,
//       status: "Pending",
//       date: DateTime.now(),
//       reason: "I am not feeling well and doctor advise me 2 days rest"),
//   RequestModel(
//       type: "Casual",
//       days: 3,
//       status: "Approved",
//       date: DateTime.now().subtract(Duration(days: 1)),
//       reason: "My father is sick"),
//   RequestModel(
//       type: "Parental",
//       days: 5,
//       status: "Approved",
//       date: DateTime.now().subtract(Duration(days: 2)),
//       reason: "My baby is going to be boen "),
//   RequestModel(
//       type: "Casual",
//       days: 1,
//       status: "Rejected",
//       date: DateTime.now().subtract(Duration(days: 3)),
//       reason: "Going on the trip"),
//   RequestModel(
//       type: "Sick",
//       days: 3,
//       status: "Pending",
//       date: DateTime.now().subtract(Duration(days: 4)),
//       reason: "I am not feeling well and doctor advise me 2 days rest"),
//   RequestModel(
//       type: "Sick",
//       days: 2,
//       status: "Pending",
//       date: DateTime.now(),
//       reason: "I am not feeling well and doctor advise me 2 days rest"),
//   RequestModel(
//       type: "Casual",
//       days: 3,
//       status: "Approved",
//       date: DateTime.now().subtract(Duration(days: 1)),
//       reason: "My father is sick"),
//   RequestModel(
//       type: "Parental",
//       days: 5,
//       status: "Approved",
//       date: DateTime.now().subtract(Duration(days: 2)),
//       reason: "My baby is going to be boen "),
//   RequestModel(
//       type: "Casual",
//       days: 1,
//       status: "Rejected",
//       date: DateTime.now().subtract(Duration(days: 3)),
//       reason: "Going on the trip"),
//   RequestModel(
//       type: "Sick",
//       days: 3,
//       status: "Pending",
//       date: DateTime.now().subtract(Duration(days: 4)),
//       reason: "I am not feeling well and doctor advise me 2 days rest"),
// ];
