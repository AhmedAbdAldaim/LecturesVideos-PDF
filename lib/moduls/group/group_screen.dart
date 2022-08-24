import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lis/models/all_group_model.dart';
import 'package:lis/moduls/classes/classes_screen.dart';
import 'package:lis/moduls/group/cubit/group_cubit.dart';
import 'package:lis/moduls/group/cubit/group_states.dart';
import 'package:lis/shared/components/components.dart';
import 'package:lis/shared/components/constince.dart';

class GroupScreen extends StatelessWidget {
  const GroupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      GroupCubit.get(context).getAllGroupFun();
      return BlocConsumer<GroupCubit, GroupStates>(
        listener: (context, states) {},
        builder: (context, states) {
          var cubit = GroupCubit.get(context);
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              appBar: AppBar(
                title: const Text('اختر فرقتك'),
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
                  condition: cubit.allgroupModel != null &&
                      states is GroupSuccessState,
                  builder: (context) {
                    return cubit.allgroupModel!.allCourseDataList != null
                        ? Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 20,
                                        crossAxisSpacing: 20),
                                itemCount: cubit.allgroupModel!
                                    .allCourseDataList!.allGroupList.length,
                                itemBuilder: (context, index) {
                                  return buildGroupItem(
                                      cubit.allgroupModel!.allCourseDataList!
                                          .allGroupList[index],
                                      context);
                                }),
                          )
                        : const Center(
                            child: Text('لا توجد اي فرق!'),
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

Widget buildGroupItem(AllGroupDataModel model, BuildContext context) {
  return InkWell(
    onTap: () {
      navigateTo(
          context,
          ClassesScreen(
            groubId: model.id,
          ));
    },
    child: Card(
      elevation: 5.0,
      child: Center(
          child:
              Container(color: Colors.amber, child: Text(model.categoryName!))),
    ),
  );
}
