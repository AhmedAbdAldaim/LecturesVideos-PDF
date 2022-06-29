import 'package:lis/models/login_model.dart';

abstract class LoginStates {}

class InitState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccesstState extends LoginStates {
   final LoginModel loginModel;
  LoginSuccesstState(this.loginModel);
}

class LoginErrorState extends LoginStates {}
