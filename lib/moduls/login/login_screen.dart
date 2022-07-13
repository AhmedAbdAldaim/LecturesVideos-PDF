import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lis/moduls/courses/courses_screen.dart';
import 'package:lis/moduls/group/group_screen.dart';
import 'package:lis/shared/components/components.dart';
import 'package:lis/shared/network/local/shredprefrences_helper.dart';
import 'package:loader_overlay/loader_overlay.dart';

import 'cubit/login_cubit.dart';
import 'cubit/login_states.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController univerNumberController = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {
        if (state is LoginErrorState) {
          context.loaderOverlay.hide();
          defaultDialog(
              context: context,
              dialogType: DialogType.ERROR,
              title: 'خطأ',
              massage: "عفوا , هناك خطأ في الخادم");
        }
        if (state is LoginSuccesstState) {
          if (state.loginModel.status) {
            SharedPrefrencesHelper.setData(
                    key: 'id', value: state.loginModel.userData!.univerNumber)
                .then((value) {
              if (value) {
                context.loaderOverlay.hide();
                navigatepushAndRemoveUntil(context, const GroupScreen());
              }
            });
          } else {
            context.loaderOverlay.hide();
            defaultDialog(
                context: context,
                dialogType: DialogType.ERROR,
                title: 'خطأ',
                massage: "عفوا , هناك خطأ في كلمة المرور او البريد الالكتروني");
          }
        }
      },
      builder: (context, state) {
        var cubit = LoginCubit.get(context);
        return Directionality(
          textDirection: TextDirection.rtl,
          child: LoaderOverlay(
            useDefaultLoading: true,
            overlayColor: Colors.black,
            overlayOpacity: 0.3,
            child: Stack(
              children: [
                Image.asset(
                  'assets/images/bacckground.jpeg',
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  fit: BoxFit.cover,
                ),
                Scaffold(
                  backgroundColor: Colors.black.withOpacity(0.7),
                  resizeToAvoidBottomInset: false,
                  appBar: AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0.0,
                    toolbarHeight: 100,
                    title: Row(
                      children: [
                        Image.asset(
                          'assets/images/logo.png',
                          width: 50,
                          height: 50,
                        ),
                        const SizedBox(width: 5.0,),
                        Text('جامعة النيلين' , style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Colors.white
                        ),),
                      ],
                    ),
                  ),
                  body: Center(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Form(
                          key: formkey,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 40,
                              ),
                              Material(
                                  elevation: 3.0,
                                  borderRadius: BorderRadius.circular(10),
                                  child: defaultTextFormFaild(
                                      controller: univerNumberController,
                                      type: TextInputType.phone,
                                      hint: 'ادخل الرقم الجامعي',
                                      action: TextInputAction.done,
                                      icon: const Icon(
                                        Icons.numbers_rounded,
                                        color: Colors.amber,
                                      ),
                                      valid: (val) {
                                        if (val.isEmpty) {
                                          return 'الرجاء إدخال الرقم الجامعي !';
                                        }

                                        return null;
                                      })),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.amber),
                                child: defaultButton(
                                    onPressed: () {
                                      if (formkey.currentState!.validate()) {
                                        //LOADING
                                        context.loaderOverlay.show();
                                        cubit.loginFun(
                                            univerNumber:
                                                univerNumberController.text);
                                      }
                                    },
                                    title: 'تسجيل الدخول'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
