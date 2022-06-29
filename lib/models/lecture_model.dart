class LectureModel {
  late bool status;
  late String message;
  LectureDataList? lectureDataList;
  LectureModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    lectureDataList = json['lectures-data']!=null? LectureDataList.fromJson(json['lectures-data']):null;
  }
}

class LectureDataList {
  List<LectureDataModel> lectureList = [];
  LectureDataList.fromJson(List<dynamic>? list) {
    
    list!.forEach((element) {
      lectureList.add(LectureDataModel.fromJson(element));
    });
  }
}

class LectureDataModel {
  late int id;
  late String lectureTitle;
  late String lectureVideo;
  late String lectureFile;

  LectureDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lectureTitle = json['lecture_title'];
    lectureVideo = json['lecture_video'];
    lectureFile = json['lecture_file'];
  }
}
