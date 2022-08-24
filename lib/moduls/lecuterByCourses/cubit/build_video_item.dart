import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lis/moduls/lecuterByCourses/cubit/lecture_cubit.dart';
import 'package:lis/moduls/lecuterByCourses/cubit/lecture_states.dart';
import 'package:lis/moduls/pdf.dart';
import 'package:lis/moduls/showvideo/show_video_screen.dart';
import 'package:lis/shared/components/components.dart';

class BuildVideoItem extends StatefulWidget {
  final String? url;
  final String titlepdf;
  final String pdf;
  final String title;
  final String? comment;
  final int index;

  const BuildVideoItem(
      this.titlepdf, this.pdf, this.url, this.title, this.comment, this.index,
      {Key? key})
      : super(key: key);

  @override
  State<BuildVideoItem> createState() => BuildVideoItemState();
}

class BuildVideoItemState extends State<BuildVideoItem> {
//becouse video want initState before build , so created this page
  CachedVideoPlayerController? controller;
  // late PDFDocument pdf;
  @override
  void initState() {
    controller = CachedVideoPlayerController.network(widget.url!)
      ..initialize().then((_) {
        setState(() {});
      });

    super.initState();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LectureByCoursesCubit, LectureByCoursesState>(
      listener: (c, i) {},
      builder: (c, i) {
        var cubit = LectureByCoursesCubit.get(context);
        return Center(
          child: controller!.value.isInitialized
              ? Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ListTile(
                    onTap: () {
                      navigateTo(
                          context,
                          ShowVideoScreen(widget.url!, widget.title,
                              widget.comment!, widget.index));
                    },
                    leading:  Card(
                            child: AspectRatio(
                              aspectRatio: controller!.value.aspectRatio,
                              child: CachedVideoPlayer(controller!),
                            ),
                          ),
                    title: Row(
                      children: [
                        Text("${widget.index}-"),
                        Text(
                          widget.title,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                              navigateTo(context, PDFScreen(pdf: widget.pdf));
                            },
                            icon: Icon(Icons.picture_as_pdf)),
                        IconButton(
                            onPressed: () async {
                              await cubit.saveFile(
                                  widget.pdf,
                                  widget.titlepdf +
                                      '_' +
                                      DateTime.now().toString());
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'تم تحميل الملف بنجاح!',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(Icons.download))
                      ],
                    ),
                  ),
                )
              : Container(),
        );
      },
    );
  }
}
