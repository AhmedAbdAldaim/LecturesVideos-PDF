import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:lis/models/all_comments_model.dart';
import 'package:lis/moduls/lecuterByCourses/cubit/lecture_states.dart';
import 'package:lis/moduls/showvideo/cubit/show_video_states.dart';
import 'package:lis/shared/network/remote/dio_endpoint.dart';
import 'package:lis/shared/network/remote/dio_helper.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_player/video_player.dart';

class ShowVideoCubit extends Cubit<ShowViedoState> {
  ShowVideoCubit() : super(InitShowViedoState());

  static ShowVideoCubit get(context) => BlocProvider.of(context);

  late CachedVideoPlayerController controller;
  late Timer t;
  showVideo(String url) {
    controller = CachedVideoPlayerController.network(url)
      ..initialize().then((_) {
        controller.play();
        emit(InitVideoSuccessState());
      });
  }

  // time() {
  //   controller.addListener(() {
  //     t = Timer.periodic(const Duration(milliseconds: 100),
  //         (Timer timer) async {
  //       print(await controller.position);
  //     });
  //   });
  // }

  playVideo() {
    controller.play();
    emit(PlayVideoState());
    emit(GetCommentsSuccesState());
  }

  pauseVideo() {
    controller.pause();
    emit(PauseVideoState());
    emit(GetCommentsSuccesState());
  }

  //COMMENTS
  AllCommentsModel? allCommentsModel;
  getAllCommentsFun() {
    emit(GetCommentsLoadingState());
    DioHelper.getData(path: allComments).then((value) {
      allCommentsModel = AllCommentsModel.fromJson(value.data);
      print(value.data);
      emit(GetCommentsSuccesState());
    }).catchError((error) {
      print(error.toString());
      emit(GetCommentsErrorsState());
    });
  }

  //Save Video
  saveNetworkVideo(pathVideo) async {
    Map<Permission, PermissionStatus> statuses =
        await [Permission.storage].request();
    if (statuses[Permission.storage]!.isGranted) {
      emit(DownloadLoadingState());
      GallerySaver.saveVideo(
        pathVideo,
        albumName: 'lis',
      ).then((success) {
        emit(DownloadSuccesState());
        emit(GetCommentsSuccesState());
      }).catchError((error) {
        emit(DownloadErrorsState());
      });
    }
  }
}
