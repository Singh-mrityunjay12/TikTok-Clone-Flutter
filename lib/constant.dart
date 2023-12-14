//Colors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tic_tok/view/screen/add_video.dart';
import 'package:tic_tok/view/screen/displayvideoScreen.dart';
import 'package:tic_tok/view/screen/profileScreen.dart';
import 'package:tic_tok/view/screen/search_screen.dart';

const backgroundColor = Colors.black;
var buttonColor = Colors.red[400];
const borderColor = Colors.grey;

var pageIndex = [
  DisplayVideoScreen(),
  SearchScreen(),
  AddVideo(),
  Text('Messages'),
  ProfileScreen(userUid: FirebaseAuth.instance.currentUser!.uid),
];
