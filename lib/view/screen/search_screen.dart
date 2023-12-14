import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tic_tok/constant.dart';
import 'package:tic_tok/controller/searchUser_controller.dart';
import 'package:tic_tok/model/userModel.dart';
import 'package:tic_tok/view/screen/profileScreen.dart';
import 'package:tic_tok/view/widget/text_input.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController searchQuery = TextEditingController();
    SearchUserController searchUserController = Get.put(SearchUserController());

    return Obx(() => Scaffold(
        appBar: AppBar(
            title: Container(
          margin: EdgeInsets.all(8),
          padding: EdgeInsets.symmetric(horizontal: 3),
          height: 49,
          child: Container(
            height: 44,
            child: TextFormField(
              controller: searchQuery,
              decoration: InputDecoration(
                  hintText: "Search users",
                  prefixIcon: Icon(Icons.search),
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: borderColor,
                    ),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
              onFieldSubmitted: (value) {
                searchUserController.searchUsers(value);
              },
            ),
          ),
        )),
        body: searchUserController.searchUser.isEmpty
            ? const Center(
                child: Text("Search users"),
              )
            : ListView.builder(
                itemCount: searchUserController.searchUser.length,
                itemBuilder: (context, index) {
                  myUser user = searchUserController.searchUser[index];
                  return ListTile(
                    onTap: () {
                      // Get.snackbar("You Clicked ${user.name}", "dddffgggg");
                      Get.to(() => ProfileScreen(userUid: user.uid));
                    },
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(user.profilePhoto),
                    ),
                    title: Text(user.name),
                  );
                })));
  }
}
