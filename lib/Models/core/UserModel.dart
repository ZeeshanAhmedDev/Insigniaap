class UserModel {
  String? username;
  String? email;
  int? coins;
  double? hoursWorked;
  int? leaves;
  String? designation;
  String? photo;
  String? role;
  String? id;
  String? officeId;
  String? joiningDate;
  String? attendanceMark;

  UserModel(
      {this.username,
      this.coins,
      this.designation,
      this.email,
      this.attendanceMark,
      this.id,
      this.officeId,
      this.photo,
      this.role,
      this.hoursWorked,
      this.joiningDate,
      this.leaves});

  // create the user object from json input
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        username: json['username'],
        hoursWorked: json['hoursWorked'].toDouble(),
        joiningDate: json['JoiningDate'],
        leaves: json['leaves'],
        role: json['role'],
        id: json['_id'],
        officeId: json['officeId'],
        email: json["email"],
        attendanceMark: json['attendanceMark'],
        coins: json['coins'],
        photo: json['photo'],
        designation: json['designation']);
  }

  // exports to json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['coins'] = this.coins;
    data['hoursWorked'] = this.hoursWorked;
    data['email'] = this.email;
    data['leaves'] = this.leaves;
    data['_id'] = this.id;
    data['attendanceMark'] = this.attendanceMark;
    data['role'] = this.role;
    data['officeId'] = this.officeId;
    data['designation'] = this.designation;
    data['photo'] = this.photo;
    data['JoiningDate'] = this.joiningDate;
    data['designation'] = this.designation;
    return data;
  }
}
