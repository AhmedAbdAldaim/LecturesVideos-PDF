import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

//TextFormField
Widget defaultTextFormFaild(
    {required TextEditingController controller,
    required TextInputType type,
    required String hint,
    required TextInputAction action,
    required Icon icon,
    required FormFieldValidator valid,
    bool ispassword = false,
    Icon? suffixicon,
    VoidCallback? changepassword}) {
  return TextFormField(
    controller: controller,
    keyboardType: type,
    style: const TextStyle(fontFamily: 'ar_font'),
    decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(fontFamily: 'ar_font'),
        prefixIcon: icon,
        border: InputBorder.none,
        suffixIcon: suffixicon != null
            ? IconButton(onPressed: changepassword, icon: suffixicon)
            : null),
    obscureText: ispassword,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    validator: valid,
    textInputAction: action,
  );
}

//Eleve Button
Widget defaultButton({
  required VoidCallback onPressed,
  required String title,
}) {
  return MaterialButton(
    onPressed: onPressed,
    padding: const EdgeInsets.all(15.0),
    child: Text(title),
  );
}

//navigat to PUSH
Future navigateTo(BuildContext context, widget) {
  return Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => widget));
}

//navigat and replace
navigatepushAndRemoveUntil(BuildContext context, widget) {
  return Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => widget), (route) {
    return false;
  });
}

//navigat to POP
navigateBack(BuildContext context) {
  return Navigator.of(context).pop();
}

//appBar
defaultappBar(BuildContext context) {
  return AppBar(
    leading: IconButton(
        onPressed: () {
          navigateBack(context);
        },
        icon: Icon(Icons.arrow_back_ios_outlined)),
  );
}

//flutter Toast
defautToast({required String message, required StateToast state}) {
  return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: ToastColors(state),
      textColor: Colors.white,
      fontSize: 16.0);
}

enum StateToast { SUCCES, ERROR, WRANG }

Color ToastColors(StateToast state) {
  late Color color;
  switch (state) {
    case StateToast.SUCCES:
      color = Colors.green;
      break;
    case StateToast.ERROR:
      color = Colors.red;
      break;
    case StateToast.WRANG:
      color = Colors.amber;
      break;
  }
  return color;
}

//Dialog
Future defaultDialog(
    {required BuildContext context,
    required DialogType dialogType,
    required String title,
    required String massage}) {
  return AwesomeDialog(
    context: context,
    animType: AnimType.SCALE,
    dialogType: dialogType,
    body: Text(
      massage,
      textAlign: TextAlign.center,
    ),
    title: title,
    btnOkColor: Colors.black12,
    btnOk: ElevatedButton(
      onPressed: () {
        navigateBack(context);
      },
      style: ElevatedButton.styleFrom(primary: Colors.grey),
      child: const Text('موافق'),
    ),
    btnOkText: 'موافق',
    btnOkOnPress: () {},
  ).show();
}
