// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tic_tok/controller/authController.dart';
import 'package:tic_tok/controller/profileController.dart';
import 'package:tic_tok/view/screen/displayvideoScreen.dart';

class ProfileScreen extends StatefulWidget {
  String userUid;
  ProfileScreen({super.key, required this.userUid});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController profileController = Get.put(ProfileController());
  final Registrations registrations = Get.put(Registrations());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    profileController.updateUserID(widget.userUid);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: AppBar(
            title: Text('@${profileController.user["name"]}'),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {
                  registrations.signOut();
                  Get.snackbar("TikTok Clone Yt App", "Current Version 1.0");
                },
                icon: Icon(Icons.info_outline_rounded),
              )
            ],
          ),
          body: profileController.user.isEmpty
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: SafeArea(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipOval(
                                child: CachedNetworkImage(
                              imageUrl: profileController.user['profilePic'],
                              fit: BoxFit.cover,
                              height: 80,
                              width: 80,
                              //till when image will load till then use placeholder to execute CircularProgressIndicator()
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                              //if at image loading time arise )any problem then use here errorWidget to show error
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ))
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  profileController.user['followers'],
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("Followers",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400))
                              ],
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  profileController.user['following'],
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("Followings",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400))
                              ],
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  profileController.user['likes'],
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("Likes",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400))
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 35,
                        ),
                        InkWell(
                          onTap: () {
                            if (widget.userUid ==
                                FirebaseAuth.instance.currentUser!.uid) {
                              registrations.signOut();
                            } else {
                              profileController.followUsers();
                            }
                          },
                          child: Container(
                              width: 150,
                              height: 50,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black, width: 0.6),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: Text(
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                    widget.userUid ==
                                            FirebaseAuth
                                                .instance.currentUser!.uid
                                        ? "Sign Out"
                                        : profileController.user['isFollowing']
                                            ? "Following"
                                            : "Follow"),
                              )),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Divider(
                          indent: 30,
                          endIndent: 30,
                          thickness: 2,
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 5,
                                    mainAxisSpacing: 5),
                            itemCount:
                                profileController.user['thumbNails'].length,
                            itemBuilder: (context, index) {
                              String thumbnail =
                                  profileController.user['thumbNails'][index];
                              return CachedNetworkImage(
                                height: 100,
                                width: 100,
                                imageUrl: thumbnail,
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              );
                            }),
                      ],
                    ),
                  ),
                ),
        ));
  }
}
