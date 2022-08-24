import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lis/models/lecture_model.dart';
import 'package:lis/moduls/lecuterByCourses/cubit/lecture_states.dart';
import 'package:lis/shared/network/remote/dio_endpoint.dart';
import 'package:lis/shared/network/remote/dio_helper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class LectureByCoursesCubit extends Cubit<LectureByCoursesState> {
  LectureByCoursesCubit() : super(InitLectureByCoursesState());

  static LectureByCoursesCubit get(context) => BlocProvider.of(context);

  LectureModel? lectureModel;
  getAllLectureByCoursesFun({required int coursesId}) {
    emit(GetLectureByCourseLoadingState());
    DioHelper.postData(path: lecture, data: {'course_id': coursesId})
        .then((value) {
      lectureModel = LectureModel.fromJson(value.data);
      emit(GetLectureByCourseSuccesState());
    }).catchError((error) {
      print(error.toString());
      emit(GetLectureByCourseErrorsState());
    });
  }

   Future<bool> saveFile(String url, String fileName) async {
    try {
      var statuses = await Permission.storage.request();
      if (statuses.isGranted) {
        Directory? directory;
        directory = await getExternalStorageDirectory();
        String newPath = "";
        List<String> paths = directory!.path.split("/");
        for (int x = 1; x < paths.length; x++) {
          String folder = paths[x];
          if (folder != "Android") {
            newPath += "/" + folder;
          } else {
            break;
          }
        }
        newPath = newPath + "/PDF_Download";
        directory = Directory(newPath);

        File saveFile = File(directory.path + "/$fileName");
        if (kDebugMode) {
          print(saveFile.path);
        }
        if (!await directory.exists()) {
          await directory.create(recursive: true);
        }
        if (await directory.exists()) {
          await Dio().download(
            url,
            saveFile.path,
          );
        }
      }
      return true;
    } catch (e) {
      return false;
    }
  }

}
