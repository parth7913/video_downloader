import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_downloader/screen/HomeScreen/provider/HomeProvider.dart';
import 'package:video_player/video_player.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  HomeProvider? providerTrue;
  HomeProvider? providerFalse;
  @override
  void initState() {
    super.initState();
    Provider.of<HomeProvider>(context,listen: false).LoadVideo();
  }

  @override
  Widget build(BuildContext context) {
    providerTrue = Provider.of<HomeProvider>(context,listen: true);
    providerFalse = Provider.of<HomeProvider>(context,listen: false);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("${providerTrue!.result.title}"),
        ),
        body: Column(
          children: [
            Container(
              height: 250,
              width: double.infinity,
              color: Colors.red,
              child: providerTrue!.videoPlayerController!.value.isInitialized ? AspectRatio(
                aspectRatio: providerTrue!.videoPlayerController!.value.aspectRatio,
                child: VideoPlayer(providerTrue!.videoPlayerController!),
              ) : null,
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            providerFalse!.ChangeValue();
          },
          child: providerTrue!.videoPlayerController!.value.isPlaying ? Icon(Icons.pause) : Icon(Icons.play_arrow),
        ),
      ),
    );
  }
}
