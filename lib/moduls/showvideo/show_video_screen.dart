import 'package:cached_video_player/cached_video_player.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lis/models/all_comments_model.dart';
import 'package:lis/moduls/showvideo/cubit/show_video_cubit.dart';
import 'package:lis/moduls/showvideo/cubit/show_video_states.dart';
import 'package:lis/shared/components/components.dart';

class ShowVideoScreen extends StatefulWidget {
  final String url;
  final String title;
  final String? comment;
  final int index;
  const ShowVideoScreen(this.url, this.title, this.comment, this.index,
      {Key? key})
      : super(key: key);

  @override
  State<ShowVideoScreen> createState() => _ShowVideoScreenState();
}

class _ShowVideoScreenState extends State<ShowVideoScreen> {
  late var cubit;
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      ShowVideoCubit.get(context).showVideo(widget.url);
      ShowVideoCubit.get(context).getAllCommentsFun();

      return BlocConsumer<ShowVideoCubit, ShowViedoState>(
        listener: (context, state) {
          if (state is DownloadSuccesState)
            defautToast(message: 'تم التنزيل بنجاح!', state: StateToast.SUCCES);
        },
        builder: (context, state) {
          cubit = ShowVideoCubit.get(context);
          print(widget.comment);
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  '${widget.index.toString()} ${widget.title} ',
                  textAlign: TextAlign.start,
                ),
              ),
              body: SafeArea(
                  child: Center(
                child: cubit.controller.value.isInitialized
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: AspectRatio(
                                aspectRatio: cubit.controller.value.aspectRatio,
                                child: CachedVideoPlayer(cubit.controller),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black38)),
                              height: 40,
                              width: double.infinity,
                              child: Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        if (cubit.controller.value.isPlaying) {
                                          cubit.pauseVideo();
                                        } else {
                                          cubit.playVideo();
                                        }
                                      },
                                      icon: cubit.controller.value.isPlaying
                                          ? const Icon(Icons
                                              .pause_circle_filled_outlined)
                                          : const Icon(Icons
                                              .play_circle_filled_outlined)),
                                  const Spacer(),
                                  IconButton(
                                      onPressed: () {
                                        cubit.saveNetworkVideo(widget.url);
                                      },
                                      icon: state is DownloadLoadingState
                                          ? const SizedBox(
                                              height: 20.0,
                                              width: 20.0,
                                              child:
                                                  CircularProgressIndicator(),
                                            )
                                          : const CircleAvatar(
                                              radius: 50,
                                              backgroundColor: Colors.green,
                                              child: Icon(
                                                Icons.download,
                                                color: Colors.white,
                                                size: 16,
                                              )))
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const[
                                  Icon(Icons.chat),
                                  Text('الملاحظات'),
                                ],
                              ),
                            ),
                            if(widget.comment=="")
                            const Padding(
                              padding:  EdgeInsets.all(14.0),
                              child: Text('لا توجد ملاحظات.'),
                            )
                            else
                            Padding(
                            padding: const EdgeInsets.all(14.0),
                            child:Expanded(
                              child: Card(
                                elevation: 0.0,
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadiusDirectional
                                            .only(
                                                bottomEnd:
                                                    Radius.circular(
                                                            15),
                                                bottomStart:
                                                    Radius
                                                        .circular(
                                                            3),
                                                topEnd: Radius
                                                    .circular(15),
                                                topStart: Radius
                                                    .circular(
                                                        15))),
                                color: Colors.black.withOpacity(0.4),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
                                  child: Text(widget.comment!,
                                      maxLines: 3,
                                      textAlign:
                                          TextAlign.start,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .copyWith(
                                              color:
                                                  Colors.white,
                                              overflow:
                                                  TextOverflow
                                                      .ellipsis)),
                                ),
                              ),
                            )
                             
                                  )      
                          ],
                        ),
                      )
                    : const SizedBox(
                        height: 0.0,
                      ),
              )),
            ),
          );
        },
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    cubit.controller.dispose();
  }

  Widget buildCommentsItem(
      BuildContext context, AllCommentDataModel allcomentModel) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 5.0,
          horizontal: 10.0,
        ),
        decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.3),
            borderRadius: const BorderRadiusDirectional.only(
                bottomEnd: Radius.circular(10.0),
                topEnd: Radius.circular(10.0),
                topStart: Radius.circular(10.0))),
        child: Text(allcomentModel.description!),
      ),
    );
  }
}
