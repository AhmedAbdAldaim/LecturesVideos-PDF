import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lis/models/all_course_model.dart';
import 'package:lis/moduls/courses/cubit/courses_cubit.dart';
import 'package:lis/moduls/courses/cubit/courses_states.dart';
import 'package:lis/moduls/lecuterByCourses/lecture_screen.dart';
import 'package:lis/shared/components/components.dart';
import 'package:lis/shared/components/constince.dart';
import 'package:shimmer/shimmer.dart';

class CoursesScreen extends StatelessWidget {
  const CoursesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      CoursesCubit.get(context).getAllCoursesFun();

      return BlocConsumer<CoursesCubit, CoursesState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = CoursesCubit.get(context);
          return Directionality(
              textDirection: TextDirection.rtl,
              child: Scaffold(
                appBar: AppBar(
                  title: Text('المحاضرات'),
                  toolbarHeight: 60,
                  leading: IconButton(
                      onPressed: () {
                        logOut(context);
                      },
                      icon: const Icon(
                        Icons.logout_outlined,
                        color: Colors.red,
                      )),
                ),
                body: ConditionalBuilder(
                    condition: state is GetCoursesSuccesState &&
                        cubit.allCourseModel != null,
                    builder: (context) =>cubit.allCourseModel!.allCourseDataList!=null? Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: GridView.builder(
                              physics: const BouncingScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 20,
                                      crossAxisSpacing: 20),
                              itemCount: cubit.allCourseModel!
                                  .allCourseDataList!.allCourseList.length,
                              itemBuilder: (context, i) => buildCorusesItem(
                                  context,
                                  cubit.allCourseModel!.allCourseDataList!
                                      .allCourseList[i])),
                        ):Center(child: Text('لا توجد كورسات!')),
                    fallback: (context) => Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 20,
                                      mainAxisSpacing: 20),
                              itemBuilder: (context, i) =>
                                  buildShimmerCorusesItem()),
                        )),
              ));
        },
      );
    });
  }

  Widget buildCorusesItem(
      BuildContext context, AllCourseDataModel coursesModel) {
    return InkWell(
      onTap: () {
        navigateTo(context, LecturesByCourses(coursesID: coursesModel.id,courseName: coursesModel.courseName,));
      },
      child: Container(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              image: const DecorationImage(
                image: AssetImage(
                  'assets/images/bacckground.jpeg',
                ),
                fit: BoxFit.cover,
              )),
          child: Card(
            elevation: 0.0,
            margin: const EdgeInsets.all(0.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            color: Colors.black.withOpacity(0.8),
            child: Center(
                child: Text(coursesModel.courseName,
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Colors.white, overflow: TextOverflow.ellipsis))),
          )),
    );
  }

  Widget buildShimmerCorusesItem() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              image: const DecorationImage(
                image: AssetImage(
                  'assets/images/bg1.jpeg',
                ),
                fit: BoxFit.cover,
              ))),
    );
  }
}
