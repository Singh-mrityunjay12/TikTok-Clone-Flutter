import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:tic_tok/model/videoModel.dart';
import 'package:tic_tok/view/screen/HomeScreen.dart';
import 'package:uuid/uuid.dart';
import 'package:video_compress/video_compress.dart';

class VideoUploadController extends GetxController {
  var uuid = const Uuid();
//5.
  _getThumb(String videoPath) async {
    //thumbnail of video
    final thumbNail = await VideoCompress.getFileThumbnail(videoPath,
        quality: 50, position: -1);
    return thumbNail;
  }

  //4.
  Future<String> _uploadVideoThumbToStorage(String id, String videoPath) async {
    Reference reference =
        FirebaseStorage.instance.ref().child("thumbNail").child(id);
    UploadTask uploadTask = reference.putFile(await _getThumb(videoPath));
    TaskSnapshot snapshot = await uploadTask;
    String downLoadUrl = await snapshot.ref.getDownloadURL();
    return downLoadUrl;
  }

  //Main Video Upload
  //Video to Storage
  //Video to compress
  //Video thumb gen
  //Video thumb to storage
  //1.
  uploadVideo(String songName, String caption, String videoPath) async {
    try {
      String Uid = FirebaseAuth.instance.currentUser!
          .uid; //uid hamara null bhi ho sakata h isiliye nullchake lagana hota h
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(Uid)
          .get(); //fetch document from the firebase

      //vedio ko unic id dene ke liye ham ak pakage instal karate h jise ham uuid ke name janate h
      //kyoki jab bhi hamlog video ko upload karate h to use ak unic id se save karate h
      String id1 = uuid.v1();
      String videoUrl = await _uploadVideoToStorage(id1, videoPath);
      String thumbNail = await _uploadVideoThumbToStorage(id1, videoPath);
      //Instance of videoModel
      Video video = Video(
          userName: (userDoc.data()! as Map<String, dynamic>)['name'],
          uid: Uid,
          id: id1,
          likes: [],
          commentCount: 0,
          shareCount: 0,
          songName: songName,
          caption: caption,
          videoUrl: videoUrl,
          thumbNail: thumbNail,
          profilePic: (userDoc.data()! as Map<String, dynamic>)['profilePic']);

      //upload the video into firebase

      await FirebaseFirestore.instance
          .collection("Videos")
          .doc(id1)
          .set(video.toJson1());
      Get.snackbar(
          "Video Uploaded Successfully", "Thanku you sharing your content");
      Get.to(() => HomeScreen1());
    } catch (e) {
      Get.snackbar("Error upload video", e.toString());
    }
  }

  //2.
  Future<String> _uploadVideoToStorage(String videoId, String videoPath) async {
    Reference reference =
        FirebaseStorage.instance.ref().child("videos").child(videoId);
    UploadTask uploadTask = reference.putFile(await _compressVideo(
        videoPath)); //uplaodTask is a properties of FirebaseStorage
    TaskSnapshot snapshot = await uploadTask;
    String downLoadUrl = await snapshot.ref
        .getDownloadURL(); //await ham usi ake pahale use karate h jo function future type hota h aur
    //output dene me kuch time leta ho
    return downLoadUrl;
  }

  //3.
  _compressVideo(
      String videoPath) //pakage use  for compress video  like video_compress
  async {
    final compressVideo = await VideoCompress.compressVideo(videoPath,
        quality: VideoQuality.MediumQuality);
    return compressVideo
        ?.file; //compressVideo ak MediaInfo whose we can extract file.
  }
}
