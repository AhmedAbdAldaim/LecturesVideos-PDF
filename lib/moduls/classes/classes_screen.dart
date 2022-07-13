import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lis/models/all_classes_model.dart';
import 'package:lis/moduls/classes/cubit/classes_cubit.dart';
import 'package:lis/moduls/classes/cubit/classes_states.dart';
import 'package:lis/moduls/courses/courses_screen.dart';
import 'package:lis/shared/components/components.dart';
import 'package:lis/shared/components/constince.dart';

class ClassesScreen extends StatelessWidget {
  final int groubId;
  const ClassesScreen({Key? key , required this.groubId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      ClassesCubit.get(context).getAllClassesFun();
      return BlocConsumer<ClassesCubit, ClassesStates>(
        listener: (context, states) {},
        builder: (context, states) {
          var cubit = ClassesCubit.get(context);
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              appBar: AppBar(
                title: const Text('اختر الفصل الدراسي'),
              ),
              body: ConditionalBuilder(
                  condition: cubit.allClassesModel != null &&
                      states is ClassesSuccessState,
                  builder: (context) {
                    return cubit.allClassesModel!.allClassesDataList != null
                        ? Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 1,
                                        childAspectRatio: 4,
                                        mainAxisSpacing: 20,
                                        crossAxisSpacing: 20),
                                itemCount: cubit.allClassesModel!
                                    .allClassesDataList!.allClassesList.length,
                                itemBuilder: (context, index) {
                                  return buildClassesItem(cubit
                                      .allClassesModel!
                                      .allClassesDataList!
                                      .allClassesList[index] , context , groubId);
                                }),
                          )
                        : const Center(
                            child: Text('لا توجد اي فصول!'),
                          );
                  },
                  fallback: (BuildContext context) => const Center(
                        child: CircularProgressIndicator(),
                      )),
            ),
          );
        },
      );
    });
  }
}

Widget buildClassesItem(AllClassesDataModel model , BuildContext context , int groubId) {
  return InkWell(
    onTap: () => navigateTo(context, CoursesScreen(groubID:groubId ,classesID: model.id,)),
    child: Card(
      elevation: 5.0,
      child: Container(
        alignment: AlignmentDirectional.centerStart,
        child: Row(
          children: [
            Container(width: 30,alignment: Alignment.center ,color: Colors.amber ,child: Text(model.id.toString())),
            const SizedBox(width: 10.0,),
            Text(model.classname),
          ],
        )),
    ),
  );
}
