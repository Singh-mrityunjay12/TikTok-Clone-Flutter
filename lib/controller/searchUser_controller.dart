import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tic_tok/model/userModel.dart';

class SearchUserController extends GetxController {
  final Rx<List<myUser>> _searchUser = Rx<List<myUser>>([]);

  List<myUser> get searchUser => _searchUser.value;

  searchUsers(String query) async {
    _searchUser.bindStream(await FirebaseFirestore.instance
        .collection("users")
        .where("name", isGreaterThanOrEqualTo: query)
        .snapshots()
        .map((QuerySnapshot snapshot) {
      List<myUser> retValue = [];
      for (var element in snapshot.docs) {
        retValue.add(myUser.fromSnap(element));
      }
      return retValue;
    }));
  }
}
