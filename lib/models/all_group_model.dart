class AllGroupModel {
  late bool status;
  late String message;
  AllGroubDataList? allCourseDataList;
  AllGroupModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    allCourseDataList =json['groups-data']!=null? AllGroubDataList.fromJson(json['groups-data']):null;
  }
}

class AllGroubDataList{
  List<AllGroupDataModel> allGroupList = [];
  AllGroubDataList.fromJson(List<dynamic>? list) {
    list!.forEach((element) {
      allGroupList.add(AllGroupDataModel.fromJson(element));
    });
  }

}

class AllGroupDataModel{
  late int id;
   String? categoryName;

   AllGroupDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['category_name'];
  }
}
