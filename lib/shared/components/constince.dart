import 'package:lis/moduls/login/login_screen.dart';
import 'package:lis/shared/components/components.dart';
import 'package:lis/shared/network/local/shredprefrences_helper.dart';

logOut(context) {
  SharedPrefrencesHelper.clearData()
      .then((value) => navigatepushAndRemoveUntil(context, LoginScreen()));
}
