import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lis/models/all_group_model.dart';
import 'package:lis/moduls/group/cubit/group_states.dart';
import 'package:lis/shared/network/remote/dio_endpoint.dart';
import 'package:lis/shared/network/remote/dio_helper.dart';

class GroupCubit extends Cubit<GroupStates> {
  GroupCubit() : super(InitGroup());
  static GroupCubit get(context) => BlocProvider.of(context);

  AllGroupModel? allgroupModel;
  getAllGroupFun() {
    emit(GroupLoadingState());
    DioHelper.getData(path: groups).then((value) {
      allgroupModel = AllGroupModel.fromJson(value.data);
      emit(GroupSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GroupErrorsState());
    });
  }
}
