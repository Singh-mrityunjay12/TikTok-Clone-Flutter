import 'package:cloud_firestore/cloud_firestore.dart';

class Video {
  String userName;
  String uid;
  String id;
  List likes;
  int commentCount;
  int shareCount;
  String songName;
  String caption;
  String videoUrl;
  String thumbNail;
  String profilePic;
  Video(
      {required this.userName,
      required this.uid,
      required this.id,
      required this.likes,
      required this.commentCount,
      required this.shareCount,
      required this.songName,
      required this.caption,
      required this.videoUrl,
      required this.thumbNail,
      required this.profilePic});

//Map to json store data in firebase
  Map<String, dynamic> toJson1() {
    return {
      "userName": userName,
      "uid": uid,
      "id": id,
      "likes": likes,
      "commentCount": commentCount,
      "shareCount": shareCount,
      "songName": songName,
      "caption": caption,
      "videoUrl": videoUrl,
      "thumbNail": thumbNail,
      "profilePic": profilePic
    };
  }

  //access the data from firebase
  static Video fromSnap(DocumentSnapshot snap) {
    var sst = snap.data() as Map<String, dynamic>;
    return Video(
        userName: sst["userName"],
        uid: sst["uid"],
        id: sst["id"],
        likes: sst["likes"],
        commentCount: sst["commentCount"],
        shareCount: sst["shareCount"],
        songName: sst["songName"],
        caption: sst["caption"],
        videoUrl: sst["videoUrl"],
        thumbNail: sst["thumbNail"],
        profilePic: sst["profilePic"]);
  }
}
