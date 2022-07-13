class AllCourseModel {

  AllCourseDataList? allCourseDataList;
  AllCourseModel.fromJson(List<dynamic>? list) {
  
    allCourseDataList = AllCourseDataList.fromJson(list);
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
