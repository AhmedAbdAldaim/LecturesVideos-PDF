import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lis/models/all_comments_model.dart';
import 'package:lis/moduls/comments/cubit/comments_cubit.dart';
import 'package:lis/moduls/comments/cubit/comments_states.dart';
import 'package:shimmer/shimmer.dart';

class CommentsScreen extends StatelessWidget {
  const CommentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      CommentsCubit.get(context).getAllCommentsFun();

      return BlocConsumer<CommentsCubit, CommentsState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = CommentsCubit.get(context);
          return Directionality(
              textDirection: TextDirection.rtl,
              child: ConditionalBuilder(
                    condition: state is GetCommentsSuccesState &&
                        cubit.allCommentsModel != null,
                    builder: (context) =>cubit.allCommentsModel!.allCommentDataList!=null? Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: cubit.allCommentsModel!
                                  .allCommentDataList!.allCommentsList.length,
                              itemBuilder: (context, i) => buildCorusesItem(
                                  context,
                                  cubit.allCommentsModel!.allCommentDataList!
                                      .allCommentsList[i])),
                        ):const Center(child: Text('لا توجد تعليقات!')),
                    fallback: (context) => Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, i) =>
                                  buildShimmerCorusesItem()),
                        )),
              );
        },
      );
    });
  }

  Widget buildCorusesItem(
      BuildContext context, AllCommentDataModel allcomentModel) {
    return Container(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              ),
          child: Card(
            elevation: 0.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            color: Colors.black.withOpacity(0.8),
            child: Center(
                child: Text(allcomentModel.description,
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Colors.white, overflow: TextOverflow.ellipsis))),
          )
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
