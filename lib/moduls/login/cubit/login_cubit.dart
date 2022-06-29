import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lis/models/login_model.dart';
import 'package:lis/moduls/login/cubit/login_states.dart';
import 'package:lis/shared/network/remote/dio_endpoint.dart';
import 'package:lis/shared/network/remote/dio_helper.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(InitState());
  static LoginCubit get(context) => BlocProvider.of(context);

  //login
  LoginModel? loginmodel;
  loginFun({required String univerNumber}) {
    emit(LoginLoadingState());
    DioHelper.postData(
        path: login,
        data: {'univer_number': univerNumber}).then((value) {
          print(value.data);
      loginmodel = LoginModel.fromJson(value.data);
      emit(LoginSuccesstState(loginmodel!));
    }).catchError((error) {
      print(error.toString());
      emit(LoginErrorState());
    });
  }
}
