abstract class ShowViedoState {}

class InitShowViedoState extends ShowViedoState {}

class InitVideoSuccessState extends ShowViedoState {}

class PlayVideoState extends ShowViedoState {}
class PauseVideoState extends ShowViedoState {}

//COMMENTS
class InitCommentsState extends ShowViedoState {}
class GetCommentsLoadingState extends ShowViedoState {}
class GetCommentsSuccesState extends ShowViedoState {}
class GetCommentsErrorsState extends ShowViedoState {}

class DownloadLoadingState extends ShowViedoState {}
class DownloadSuccesState extends ShowViedoState {}
class DownloadErrorsState extends ShowViedoState {}
