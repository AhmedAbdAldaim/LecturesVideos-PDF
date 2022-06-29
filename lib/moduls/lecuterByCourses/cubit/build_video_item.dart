import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/material.dart';
import 'package:lis/moduls/showvideo/show_video_screen.dart';
import 'package:lis/shared/components/components.dart';
import 'package:video_player/video_player.dart';

class BuildVideoItem extends StatefulWidget {
  final String url;
  final String title;
  final int index;

  const BuildVideoItem(this.url, this.title, this.index, {Key? key}) : super(key: key);

  @override
  State<BuildVideoItem> createState() => BuildVideoItemState();
}

class BuildVideoItemState extends State<BuildVideoItem> {

//becouse video want initState before build , so created this page
  late CachedVideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    controller = CachedVideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: controller.value.isInitialized
          ? Padding(
              padding: const EdgeInsets.all(5.0),
              child: ListTile(
                onTap: () 
                {
                  navigateTo(context, ShowVideoScreen(widget.url, widget.title ,widget.index));
                },
                leading: Card(
                  child: AspectRatio(
                    aspectRatio: controller.value.aspectRatio,
                    child: CachedVideoPlayer(controller),
                  ),
                ), 
                title: Row(
                  children: [
                    Text("${widget.index}-"),
                    Text(
                      widget.title,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            )
          : Container(),
    );
  }


  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

}
