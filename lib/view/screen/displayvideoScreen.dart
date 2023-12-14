// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:tic_tok/controller/video_controller.dart';
import 'package:tic_tok/view/screen/comment_screen.dart';
import 'package:tic_tok/view/screen/profileScreen.dart';
import 'package:tic_tok/view/widget/AlbumRotator.dart';
import 'package:tic_tok/view/widget/profileButton.dart';
import 'package:tic_tok/view/widget/tiktokVideoPlayer.dart';

class DisplayVideoScreen extends StatefulWidget {
  const DisplayVideoScreen({super.key});

  @override
  State<DisplayVideoScreen> createState() => _DisplayVideoScreenState();
}

class _DisplayVideoScreenState extends State<DisplayVideoScreen> {
  final VideoController controller = Get.put(VideoController());

  Future<void> share(String vidId) async {
    await FlutterShare.share(
        title: 'Download My TikTok Clone App',
        text: 'Watch Intresting short videos On TikTok Clone',
        linkUrl: vidId);
    controller.shareVideo(vidId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return PageView.builder(
            scrollDirection: Axis.vertical,
            controller: PageController(initialPage: 0, viewportFraction: 1),
            itemCount: controller.videoList.length,
            itemBuilder: (context, index) {
              final data = controller.videoList[index];
              return SafeArea(
                child: InkWell(
                  onDoubleTap: () {
                    controller.likedVideo(data.id);
                  },
                  child: Stack(
                    children: [
                      TikTokVideoPLayer(videoUrl: data.videoUrl),
                      Container(
                        margin: EdgeInsets.only(left: 15, bottom: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data.userName,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              data.caption,
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              data.songName,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        right: 0,
                        child: Container(
                          // width: 140,
                          height: MediaQuery.of(context).size.height - 400,
                          margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height / 3,
                              right: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                  onTap: () {
                                    Get.to(
                                        () => ProfileScreen(userUid: data.uid));
                                  },
                                  child: ProfileButton(
                                      profilePhotoUrl: data.profilePic)),
                              InkWell(
                                onTap: () {
                                  controller.likedVideo(
                                      data.id); //ye id video ka id h
                                },
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.favorite,
                                      color: data.likes.contains(FirebaseAuth
                                              .instance.currentUser!.uid)
                                          ? Colors.pink
                                          : Colors.white,
                                      size: 45,
                                    ),
                                    Text(
                                      "${data.likes.length.toString()}",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  share(data.id); //id is the video id
                                },
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.reply,
                                      color: Colors.white,
                                      size: 45,
                                    ),
                                    Text(
                                      data.shareCount.toString(),
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CommentScreen(
                                                id: data.id,
                                              )));
                                },
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.comment,
                                      color: Colors.white,
                                      size: 45,
                                    ),
                                    Text(
                                      data.commentCount.toString(),
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Column(
                                      children: [
                                        AlbumRotatorScreen(
                                          profilePickUrl: data.profilePic,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            });
      }),
    );
  }
}
