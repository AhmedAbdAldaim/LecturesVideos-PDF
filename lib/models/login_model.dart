class LoginModel {
  late bool status;
  late String message;
  UserDataModel? userData;
  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    userData = json['student-data'] != null
        ? UserDataModel.fromJson(json['student-data'])
        : null;
  }
}

class UserDataModel {
  late int id;
  late String? studentName;
  late String? univerNumber;

  UserDataModel.fromJson(List<dynamic> list) {
    list.forEach((element) {
      id = element['id'];
      studentName = element['student_name'];
      univerNumber = element['univer_number'];
    });
  }
}
