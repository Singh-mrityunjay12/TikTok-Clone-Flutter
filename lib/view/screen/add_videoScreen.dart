import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:tic_tok/constant.dart';
import 'package:tic_tok/controller/upload_video_controller.dart';
import 'package:tic_tok/view/widget/text_input.dart';
import 'package:video_player/video_player.dart';

// ignore: must_be_immutable
class AddScreen extends StatefulWidget {
  File videoFile;
  String VideoPath;
  AddScreen({Key? key, required this.videoFile, required this.VideoPath})
      : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  TextEditingController songNameController = TextEditingController();
  TextEditingController songCaptionController = TextEditingController();
  late VideoPlayerController videoPlayerController;
  VideoUploadController videoUploadController =
      Get.put(VideoUploadController());
  Widget UploadContent = Text("Upload");

  uploadVid() {
    UploadContent = Text("Please Wait..");
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    videoPlayerController.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      //video_player package keep properties of VideoPlayerController.file()
      videoPlayerController = VideoPlayerController.file(widget
          .videoFile); //jab hamlog stateful class me value ko use karete h to aise karate h
      videoPlayerController.initialize();
      videoPlayerController.play();
      videoPlayerController.setLooping(true); //isase loop me chalega
      videoPlayerController.setVolume(0.7);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 1.5,
            width: MediaQuery.of(context).size.width,
            child: VideoPlayer(videoPlayerController),
          ),
          Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              height: MediaQuery.of(context).size.height / 4,
              child: Column(children: [
                TextInputField(
                  controller: songNameController,
                  myLabelText: "Song Name",
                  myIcon: Icons.music_note,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextInputField(
                    controller: songCaptionController,
                    myIcon: Icons.closed_caption,
                    myLabelText: "Caption"),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    uploadVid();
                    videoUploadController.uploadVideo(
                        songNameController.text.trim(),
                        songCaptionController.text.trim(),
                        widget.VideoPath);
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: buttonColor),
                  child: UploadContent,
                )
              ]))
        ],
      ),
    ));
  }
}
