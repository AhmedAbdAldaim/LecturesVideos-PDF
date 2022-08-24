import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lis/moduls/classes/cubit/classes_cubit.dart';
import 'package:lis/moduls/comments/cubit/comments_cubit.dart';
import 'package:lis/moduls/courses/cubit/courses_cubit.dart';
import 'package:lis/moduls/group/cubit/group_cubit.dart';
import 'package:lis/moduls/group/group_screen.dart';
import 'package:lis/moduls/lecuterByCourses/cubit/lecture_cubit.dart';
import 'package:lis/moduls/login/cubit/login_cubit.dart';
import 'package:lis/moduls/login/login_screen.dart';
import 'package:lis/moduls/showvideo/cubit/show_video_cubit.dart';
import 'package:lis/shared/network/local/shredprefrences_helper.dart';
import 'package:lis/shared/network/remote/dio_helper.dart';
import 'package:lis/shared/observer.dart';
import 'package:lis/shared/style/colors.dart';
import 'package:lis/shared/style/theme.dart';

void main() {
  BlocOverrides.runZoned(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await SharedPrefrencesHelper.initilazitonSharedPrefrences();
    DioHelper.initilazitonDioHelper();
    runApp(MyApp());
  }, blocObserver: MyBlocObserver());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final String? id = SharedPrefrencesHelper.getData(key: 'id');

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => GroupCubit()),
        BlocProvider(create: (context) => ClassesCubit()),
        BlocProvider(create: (context) => CoursesCubit()),
        BlocProvider(create: (context) => LectureByCoursesCubit()),
        BlocProvider(create: (context) => ShowVideoCubit()),
        BlocProvider(create: (context) => CommentsCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ligththeme,
        home: id == null ? LoginScreen() : const GroupScreen(),
      ),
    );
  }
}
