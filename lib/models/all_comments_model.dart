class AllCommentsModel {
  late bool status;
  late String message;
  AllCommentDataList? allCommentDataList;
  AllCommentsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    allCommentDataList =json['comments-data']!=null? AllCommentDataList.fromJson(json['comments-data']):null;
  }
}

class AllCommentDataList {
  List<AllCommentDataModel> allCommentsList = [];
  AllCommentDataList.fromJson(List<dynamic>? list) {
    list!.forEach((element) {
      allCommentsList.add(AllCommentDataModel.fromJson(element));
    });
  }
}

class AllCommentDataModel {
  late int id;
  late String description;

  AllCommentDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
  }
}
