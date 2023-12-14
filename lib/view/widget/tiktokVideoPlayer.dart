import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class TikTokVideoPLayer extends StatefulWidget {
  TikTokVideoPLayer({super.key, required this.videoUrl});
  String videoUrl;

  @override
  State<TikTokVideoPLayer> createState() => _TikTokVideoPLayerState();
}

class _TikTokVideoPLayerState extends State<TikTokVideoPLayer> {
  late VideoPlayerController videoPlayerController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    videoPlayerController = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((value) {
        videoPlayerController
            .play(); //after that using  this property video play
        videoPlayerController.setLooping(
            true); //after that using  this property video play in loop
      });
  }

  //isake bad video ko end ho jata h ise disposed bhi karana padega jab ham is video ko khatm kar rahe h nahi to ye aur memory leta rahega
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.height,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(color: Colors.black),
      child: VideoPlayer(videoPlayerController),
    );
  }
}
