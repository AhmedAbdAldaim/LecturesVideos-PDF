import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lis/models/all_classes_model.dart';
import 'package:lis/moduls/classes/cubit/classes_states.dart';
import 'package:lis/shared/network/remote/dio_endpoint.dart';
import 'package:lis/shared/network/remote/dio_helper.dart';

class ClassesCubit extends Cubit<ClassesStates> {
  ClassesCubit() : super(InitClasses());
  static ClassesCubit get(context) => BlocProvider.of(context);

  AllClassesModel? allClassesModel;
  getAllClassesFun() {
    emit(ClassesLoadingState());
    DioHelper.getData(path: classes).then((value) {
      allClassesModel = AllClassesModel.froJson(value.data);
      emit(ClassesSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ClassesErrorsState());
    });
  }
}
