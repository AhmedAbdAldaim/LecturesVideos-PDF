import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lis/models/lecture_model.dart';
import 'package:lis/moduls/lecuterByCourses/cubit/lecture_cubit.dart';
import 'package:lis/moduls/lecuterByCourses/cubit/lecture_states.dart';
import 'package:lis/moduls/lecuterByCourses/cubit/build_video_item.dart';
import 'package:shimmer/shimmer.dart';

class LecturesByCourses extends StatelessWidget {
  final int coursesID;
  final String courseName;
  const LecturesByCourses({Key? key, required this.coursesID , required this.courseName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      LectureByCoursesCubit.get(context).getAllLectureByCoursesFun(coursesId: coursesID);

      return BlocConsumer<LectureByCoursesCubit, LectureByCoursesState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = LectureByCoursesCubit.get(context);
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
                appBar: AppBar(
                  title: Text(courseName),
                ),
                body: ConditionalBuilder(
                  condition: state is GetLectureByCourseSuccesState && cubit.lectureModel != null,
                  builder: (context) => cubit.lectureModel!.lectureDataList!=null? Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                         padding: const EdgeInsets.symmetric(horizontal: 2),
                          decoration: BoxDecoration(
                             color: Colors.amber,
                            borderRadius: BorderRadius.circular(3)
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text('عدد المحاضرات:'),
                              const SizedBox(width: 5,),
                              Text(cubit.lectureModel!.lectureDataList!.lectureList.length.toString()),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10,),
                        const Divider(height: 10, color: Colors.grey,),
                        Expanded(
                          child: ListView.separated(
                              itemCount: cubit.lectureModel!.lectureDataList!.lectureList.length,
                              itemBuilder: (context, i) {
                                return buildLectureItem(
                                  context,
                                  cubit.lectureModel!.lectureDataList!.lectureList[i],i
                                );
                              },
                              separatorBuilder: (BuildContext context, int index) =>
                                  const Divider(
                                    height: 10,
                                    color: Colors.black26,
                                  )),
                        ),
                      ],
                    ),
                  ):const Center(child: Text('لا توجد محاضرات!')),
                  fallback: (context) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ListView.builder(physics: const NeverScrollableScrollPhysics(),itemBuilder: (c,i)=> shimmerLoading()),
                  )),
                )
          );
        },
      );
    });
  }

  Widget buildLectureItem(BuildContext context, LectureDataModel lectureModel , index) {
    return BuildVideoItem(
         lectureModel.lectureFile!,
         'http://192.168.43.176:8000/uploads/${lectureModel.lectureFile}',
        'http://192.168.43.176:8000/uploads/${lectureModel.lectureVideo}',
        lectureModel.lectureTitle! , lectureModel.comment! ,index);
  }
}


Shimmer shimmerLoading() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 60,
            width: 80,
            color: Colors.white,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20.0,),
                Container(
                  height: 16,
                  width: double.infinity,
                  color: Colors.white,
                ),
                 const SizedBox(height: 10.0,),
                
              ],
            ),
          ),
        ],

      ),
    ),
  );
}



