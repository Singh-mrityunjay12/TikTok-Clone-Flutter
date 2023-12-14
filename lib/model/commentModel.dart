import 'package:cloud_firestore/cloud_firestore.dart';

class Comment1 {
  String Uid; //user id
  String id; //comment karene vale user id
  String username;
  String comment;
  final datePub;
  List likes;
  String profilePic;

  Comment1(
      {required this.Uid,
      required this.id,
      required this.username,
      required this.comment,
      required this.datePub,
      required this.likes,
      required this.profilePic});

  Map<String, dynamic> toJson() => {
        "Uid": Uid,
        "id": id,
        "username": username,
        "comment": comment,
        "datePUb": datePub,
        "likes": likes,
        "profilePic": profilePic
      };

//fetch the data from firebase use in ui screen file
  static Comment1 fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Comment1(
      //return instance(object) of the class
      username: snapshot["username"],
      comment: snapshot["comment"],
      datePub: snapshot["datePUb"],
      likes: snapshot['likes'],
      profilePic: snapshot['profilePic'],
      Uid: snapshot['Uid'],
      id: snapshot['id'],
    );
  }
}
