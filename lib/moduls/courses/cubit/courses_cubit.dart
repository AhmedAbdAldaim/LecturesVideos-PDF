import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lis/models/all_course_model.dart';
import 'package:lis/moduls/courses/cubit/courses_states.dart';
import 'package:lis/shared/network/remote/dio_endpoint.dart';
import 'package:lis/shared/network/remote/dio_helper.dart';

class CoursesCubit extends Cubit<CoursesState> {
  CoursesCubit() : super(InitCoursesState());

  static CoursesCubit get(context) => BlocProvider.of(context);

  AllCourseModel? allCourseModel;
   //List<AllCourseDataModel> allCourseList = [];
  getAllCoursesFun({
    required int classid,
    required int groupid,
  }) {
    emit(GetCoursesLoadingState());
    DioHelper.postData(path: allCourse , data: {
      'class_id':classid, 'group_id':groupid
    }).then((value) {
       print(value.data);
      allCourseModel = AllCourseModel.fromJson(value.data);
      print(value.data);
      emit(GetCoursesSuccesState());
    }).catchError((error) {
      print(error.toString());
      emit(GetCoursesErrorsState());
    });
  }
}
