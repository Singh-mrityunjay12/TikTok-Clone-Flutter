// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tic_tok/model/commentModel.dart';

class CommentController extends GetxController {
  final Rx<List<Comment1>> _comments = Rx<List<Comment1>>([]);
  List<Comment1> get comments => _comments.value;

  String _postID = "";
  updatePostID(String id) {
    _postID = id;
    fetchComment();
  }

  fetchComment() async {
    //create a stream
    _comments.bindStream(await FirebaseFirestore.instance
        .collection("Videos")
        .doc(_postID)
        .collection("comment")
        .snapshots()
        .map((QuerySnapshot snapshot) {
      List<Comment1> retVal = [];
      for (var element in snapshot.docs) {
        retVal.add(Comment1.fromSnap(element));
      }
      return retVal;
    }));
  }

  postComment(String commentText) async {
    try {
      if (commentText.isNotEmpty) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get();
        var allDocs = await FirebaseFirestore.instance
            .collection("Videos")
            .doc(_postID)
            .collection("comment")
            .get();
        int len = allDocs.docs.length;

        Comment1 comment1 = Comment1(
            Uid: FirebaseAuth.instance.currentUser!.uid,
            id: 'Comment $len',
            username: (userDoc.data()! as dynamic)['name'],
            comment: commentText.trim(),
            datePub: DateTime.now(),
            likes: [],
            profilePic: (userDoc.data()! as dynamic)['profilePic']);

        //post the comment in firebase or save the post data into firebase

        await FirebaseFirestore.instance
            .collection("Videos")
            .doc(_postID)
            .collection("comment")
            .doc('Comment $len')
            .set(comment1.toJson());

        //fetch the data from firebase
        DocumentSnapshot doc = await FirebaseFirestore.instance
            .collection("Videos")
            .doc(_postID) //_postID means is not currentUser!.uid this is id
            .get();

        //update commentCount in firebase
        await FirebaseFirestore.instance
            .collection('Videos')
            .doc(_postID)
            .update({
          'commentCount': (doc.data()! as dynamic)['commentCount'] + 1,
        });
      } else {
        Get.snackbar(
            "Please Enter some content", "Please write something in comment");
      }
    } catch (e) {
      Get.snackbar("Error in sending comment", e.toString());
    }
  }

  likeComment(String id) async {
    print(id);
    var uid = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('Videos')
        .doc(_postID)
        .collection("comment")
        .doc(id)
        .get();

    if ((doc.data()! as dynamic)['likes'].contains(uid)) {
      await FirebaseFirestore.instance
          .collection('Videos')
          .doc(_postID)
          .collection('comment')
          .doc(id)
          .update({
        'likes': FieldValue.arrayRemove([uid]),
      });
    } else {
      await FirebaseFirestore.instance
          .collection('Videos')
          .doc(_postID)
          .collection('comment')
          .doc(id)
          .update({
        'likes': FieldValue.arrayUnion([uid]),
      });
    }
  }
}
