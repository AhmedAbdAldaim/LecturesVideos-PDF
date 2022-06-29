import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lis/models/all_comments_model.dart';
import 'package:lis/models/all_course_model.dart';
import 'package:lis/moduls/comments/cubit/comments_states.dart';
import 'package:lis/shared/network/remote/dio_endpoint.dart';
import 'package:lis/shared/network/remote/dio_helper.dart';

class CommentsCubit extends Cubit<CommentsState> {
  CommentsCubit() : super(InitCommentsState());

  static CommentsCubit get(context) => BlocProvider.of(context);

  AllCommentsModel? allCommentsModel;
  getAllCommentsFun() {
    emit(GetCommentsLoadingState());
    DioHelper.getData(path: allComments).then((value) {
      allCommentsModel = AllCommentsModel.fromJson(value.data);
      print(value.data);
      emit(GetCommentsSuccesState());
    }).catchError((error) {
      print(error.toString());
      emit(GetCommentsErrorsState());
    });
  }
}
