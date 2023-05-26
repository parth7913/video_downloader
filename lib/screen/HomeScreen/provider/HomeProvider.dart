import 'package:flutter/cupertino.dart';
import 'package:video_downloader/screen/HomeScreen/model/YouTubeModel.dart';
import 'package:video_downloader/utils/ApiHelper.dart';
import 'package:video_player/video_player.dart';

class HomeProvider extends ChangeNotifier {
  TextEditingController txtSearch = TextEditingController();
  YouTubeModel? youTubeModel = YouTubeModel();
  Results result = Results();
  String search = "";
  VideoPlayerController? videoPlayerController;

  Future<void> SearchVideo() async {
    search = txtSearch.text;
    notifyListeners();
  }

  void AddValue({required Results data}) {
    result = data;
    notifyListeners();
  }

  void LoadVideo()
  {
    print("====== URL : ${result.url}");
    videoPlayerController = VideoPlayerController.network("https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4")..initialize();
    notifyListeners();
  }

  void ChangeValue() {
    if (videoPlayerController!.value.isPlaying) {
      videoPlayerController!.pause();
      print("====I Play : ${videoPlayerController!.value.isPlaying}");
    } else {
      videoPlayerController!.play();
      print("====E Play : ${videoPlayerController!.value.isPlaying}");
    }
    notifyListeners();
  }
}
