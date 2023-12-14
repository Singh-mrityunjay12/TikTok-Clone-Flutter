import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tic_tok/controller/authController.dart';
import 'package:tic_tok/model/videoModel.dart';

class VideoController extends GetxController {
//Here  we will create observable  list of Rx type
  final Rx<List<Video>> _videoList = Rx<List<Video>>([]);
  //create a getter which we can access in any file
  List<Video> get videoList =>
      _videoList.value; //here videoList is public list  we can access in file

  //whenEver we have to initialize any thing in controller file the use oninit method
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    //fetch video from firebase and display on a mobile screen
    _videoList.bindStream(FirebaseFirestore.instance
        .collection("Videos")
        .snapshots()
        .map((QuerySnapshot snapshot) {
      List<Video> retVal = [];
      for (var element in snapshot.docs) {
        retVal.add(Video.fromSnap(element));
      }

      return retVal;
    }));
  }

  //for share count
  shareVideo(String vidId) async {
    DocumentSnapshot doc =
        await FirebaseFirestore.instance.collection("Videos").doc(vidId).get();

    int newShareCount = (doc.data() as dynamic)["shareCount"] + 1;
    await FirebaseFirestore.instance
        .collection("Videos")
        .doc(vidId)
        .update({"shareCount": newShareCount});
  }

  likedVideo(String id) async {
    DocumentSnapshot doc =
        await FirebaseFirestore.instance.collection("Videos").doc(id).get();

    var uid1 = Registrations.instance.user1.uid;
    if ((doc.data() as dynamic)['likes'].contains(
        uid1)) //we change doc.data() into dynamic which we can access any data easily from this doc.data()
    {
      //yadi uid1 contain h to ham ise remove kar denge means jab ham dobara like karate h to yadi like kiye hote  to vo like hat jata h
      //vahi concept yaha use ho raha h (jaise hamlog kisi video like karate h phir dobara like per click karate h to hat jata h )
      await FirebaseFirestore.instance.collection("Videos").doc(id).update({
        "likes": FieldValue.arrayRemove([uid1])
      });
    } else {
      //yadi ak bar bhi like nahi kiye ho to ham log uid1 ko add karate h means like karate h video ko
      await FirebaseFirestore.instance.collection("Videos").doc(id).update({
        "likes": FieldValue.arrayUnion([uid1])
      });
    }
  }
}
