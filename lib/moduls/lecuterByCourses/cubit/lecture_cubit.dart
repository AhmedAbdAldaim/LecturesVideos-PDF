import 'package:bloc/bloc.dart';
import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lis/models/lecture_model.dart';
import 'package:lis/models/login_model.dart';
import 'package:lis/moduls/lecuterByCourses/cubit/lecture_states.dart';
import 'package:lis/shared/network/remote/dio_endpoint.dart';
import 'package:lis/shared/network/remote/dio_helper.dart';
import 'package:video_player/video_player.dart';

class LectureByCoursesCubit extends Cubit<LectureByCoursesState> {
  LectureByCoursesCubit() : super(InitLectureByCoursesState());

  static LectureByCoursesCubit get(context) => BlocProvider.of(context);

  LectureModel? lectureModel;
  getAllLectureByCoursesFun({required int coursesId}) {
    emit(GetLectureByCourseLoadingState());
    DioHelper.postData(path: lecture, data: {'id': coursesId}).then((value) {
      lectureModel = LectureModel.fromJson(value.data);
      emit(GetLectureByCourseSuccesState());
    }).catchError((error) {
      print(error.toString());
      emit(GetLectureByCourseErrorsState());
    });
  }



}
