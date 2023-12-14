import 'package:cloud_firestore/cloud_firestore.dart';

class myUser {
  String name;
  String profilePhoto;
  String email;
  String uid;
  myUser(
      {required this.name,
      required this.profilePhoto,
      required this.email,
      required this.uid});

  //object to map to json means serialization
  //isaka use ham App se Firebase me data bhejane ke liye use karate h aur Firebase Map fomate me data lete h means json formate me
  //map aur json around same hi hote h stucture same hi hota h
  //app to firebase
  Map<String, dynamic> toJson1() {
    return {
      "name": name,
      "profilePic": profilePhoto,
      "email": email,
      "userUid": uid
    };
  }

  //ye vala method ham tab use karate h jab ham firebase data lete h aur apane app me use karate h kyoki mera app user model ko
  //samghata h  aur static ka use isliye karate h ham ise direct use kar sake without User model ke
  // Firebase(map) to App(myUser)
  static myUser fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    //myUser jo class h vo bhi ak datatype ki tarah hota h jise myUser data bol sakate h
    //firebase se jo bhi data map formate me ata h use myUser data type convert kar dete h aur jaha bhi use karana ho kar sakate h
    return myUser(
        name: snapshot['name'],
        profilePhoto: snapshot['profilePic'],
        email: snapshot['email'],
        uid: snapshot['userUid']);
  }
}
