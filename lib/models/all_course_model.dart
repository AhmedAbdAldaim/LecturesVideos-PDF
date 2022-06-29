class AllCourseModel {
  late bool status;
  late String message;
  AllCourseDataList? allCourseDataList;
  AllCourseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    allCourseDataList =json['courses-data']!=null? AllCourseDataList.fromJson(json['courses-data']):null;
  }
}

class AllCourseDataList {
  List<AllCourseDataModel> allCourseList = [];
  AllCourseDataList.fromJson(List<dynamic>? list) {
    list!.forEach((element) {
      allCourseList.add(AllCourseDataModel.fromJson(element));
    });
  }
}

class AllCourseDataModel {
  late int id;
  late String courseName;

  AllCourseDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseName = json['course_name'];
  }
}
