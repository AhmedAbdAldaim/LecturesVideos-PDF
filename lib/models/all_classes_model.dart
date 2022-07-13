class AllClassesModel {
  late bool status;
  late String message;
  AllClassesDataList? allClassesDataList;

  AllClassesModel.froJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    allClassesDataList = json['courses-data']!=null? AllClassesDataList.fromJson(json['courses-data']):null ;
  }
}

class AllClassesDataList {
  List<AllClassesDataModel> allClassesList = [];
  AllClassesDataList.fromJson(List<dynamic>?list){
    list!.forEach((element) {
      allClassesList.add(AllClassesDataModel.fromJson(element));
    });
  }
}

class AllClassesDataModel {
  late int id;
  late String classname;
  AllClassesDataModel.fromJson(Map<String, dynamic>json){
  id = json['id'];
  classname = json['class_name'];
  }
}
