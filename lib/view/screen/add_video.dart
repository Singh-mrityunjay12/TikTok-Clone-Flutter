import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tic_tok/view/screen/add_videoScreen.dart';

import '../../constant.dart';

class AddVideo extends StatefulWidget {
  const AddVideo({Key? key}) : super(key: key);

  @override
  State<AddVideo> createState() => _AddVideoState();
}

class _AddVideoState extends State<AddVideo> {
  //pick video from gallery,camera
  videoPick(ImageSource src, BuildContext context) async {
    final video = await ImagePicker().pickVideo(source: src);
    if (video != null) {
      Get.snackbar("Video Selected", video.path);
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return AddScreen(videoFile: File(video.path), VideoPath: video.path);
      }));
    } else {
      Get.snackbar(
          "Error In Selecting Video", "Please Choose A Different Video File");
    }
  }

  showDialogOpt(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            //dialog option
            children: [
              SimpleDialogOption(
                onPressed: () => videoPick(ImageSource.gallery, context),
                child: const Text("Gallery"),
              ),
              SimpleDialogOption(
                onPressed: () {
                  return videoPick(ImageSource.camera, context);
                },
                child: const Text("Camera"),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Close"),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () {
            return showDialogOpt(context);
          },
          child: Container(
            width: 190,
            height: 50,
            decoration: BoxDecoration(color: buttonColor),
            child: const Center(
              child: Text(
                "Add Video",
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
