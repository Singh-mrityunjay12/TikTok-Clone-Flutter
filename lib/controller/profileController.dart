import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final Rx<Map<String, dynamic>> _user = Rx<Map<String, dynamic>>({});
  Map<String, dynamic> get user => _user.value;
//obeservable string

  Rx<String> _uid = "".obs;

  updateUserID(String uid) {
    _uid.value = uid;
    getmyUserData();
  }

  getmyUserData() async {
    List<String> thumbNails = [];
    var myVideos = await FirebaseFirestore.instance
        .collection("Videos")
        .where("uid",
            isEqualTo: _uid
                .value) //sabhi document ko access karate h according to this condition
        .get();

    for (int i = 0; i < myVideos.docs.length; i++) {
      thumbNails.add((myVideos.docs[i].data() as dynamic)[
          'thumbNail']); //myVideos.docs means all docs are present in Videos file with different doc id
    }

//fetch like ...... and as so on
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection("users")
        .doc(_uid
            .value) // Always we have to give condition when we are fetch data from firebase
        .get();
    final userData = userDoc.data() as dynamic;
    String name = userData['name'];
    String profilePic = userDoc['profilePic'];
    int likes = 0;
    int following = 0;
    int followers = 0;
    bool isFollowing = false;
    for (var item in myVideos.docs) {
      likes += (item.data()['likes'] as List).length;
    }

    var followerDoc = await FirebaseFirestore.instance
        .collection("users")
        .doc(_uid.value)
        .collection("followers")
        .get();
    var followingDoc = await FirebaseFirestore.instance
        .collection("users")
        .doc(_uid.value)
        .collection("following")
        .get();
    followers = followerDoc.docs.length;
    following = followingDoc.docs.length;

    ///isaka matalab ye h ki jo current time user login ho aur app use kar raha ho to yadi vo kisi ki profile chacke
    ///kar raha ho yadi usake follower me is login user ka profile dikhe to matalab ye login user use follow kiya jisaka profile dekh raha tha
    FirebaseFirestore.instance
        .collection("users")
        .doc(_uid.value)
        .collection("followers")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      if (value.exists) {
        //login user follow karata h jiska profile delk raha h
        isFollowing = true;
      } else {
        //login user follow nahi  karata h jiska profile delk raha h
        isFollowing = false;
      }
    });

    _user.value = {
      "followers": followers.toString(),
      "following": following.toString(),
      "likes": likes.toString(),
      "profilePic": profilePic,
      "name": name,
      "isFollowing": isFollowing,
      "thumbNails": thumbNails
    };
    update();
  }

  followUsers() async {
    var doc = await FirebaseFirestore.instance
        .collection("users")
        .doc(_uid.value)
        .collection("followers")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    if (!doc.exists) {
      //if istype ka document exit nahi karata h isaka matalab follow nahi kiya h means follow karana h
      print("//////////////////////////////////////////////////////////////");
      print(_uid
          .value); //here jis bhi screen ka profile dekhate h usaki id hoti h _uid.value
      print(FirebaseAuth.instance.currentUser!
          .uid); //ye us user ki id hoti h jo user login hota h means jo user app ko use kar raha h
      print("//////////////////////////////////////////////////////////////");
      await FirebaseFirestore.instance
          .collection("users")
          .doc(_uid.value)
          .collection("followers")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({});
      await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("following")
          .doc(_uid.value)
          .set({});
      //followers ko update karana h
      _user.value
          .update('followers', (value) => (int.parse(value) + 1).toString());
    } else {
      //if istype ka document exit  karata h isaka matalab follow  kiya h means unfollow karana h
      await FirebaseFirestore.instance
          .collection("users")
          .doc(_uid.value)
          .collection(
              "followers") //followers me us user id ki store hogi jis user by follow kiya ja raha h
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .delete();
      await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection(
              "following") //following me us user id ki store hogi jisako fallow kar rahe h
          .doc(_uid.value)
          .delete();
      //followers ko update karana h
      _user.value
          .update('followers', (value) => (int.parse(value) - 1).toString());
    }
    _user.value.update('isFollowing', (value) => !value);
    update();
  }
}
