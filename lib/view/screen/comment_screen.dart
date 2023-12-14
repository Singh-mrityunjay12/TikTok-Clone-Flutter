import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tic_tok/controller/comment_controller.dart';
import 'package:tic_tok/view/widget/text_input.dart';
import 'package:timeago/timeago.dart' as tago;

class CommentScreen extends StatelessWidget {
  final String id;
  CommentScreen({super.key, required this.id});
  final TextEditingController _commentController = TextEditingController();

  CommentController commentController = Get.put(CommentController());
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    commentController.updatePostID(id);
    return Scaffold(
      body: SingleChildScrollView(
        // scrollDirection: Axis.vertical,
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
            children: [
              Obx(
                () => Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: commentController.comments.length,
                      itemBuilder: (context, index) {
                        final data = commentController.comments[index];
                        return ListTile(
                          leading: CircleAvatar(
                            radius: 35,
                            backgroundImage:
                                NetworkImage(data.profilePic.toString()),
                          ),
                          title: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(data.username,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  width: 3,
                                ),
                                Text(data.comment,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                          subtitle: Row(
                            children: [
                              Text(tago.format(data.datePub.toDate())),
                              SizedBox(
                                width: 3,
                              ),
                              Text("${data.likes.length} Likes",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                          trailing: InkWell(
                            onTap: () {
                              commentController.likeComment(data.id);
                            },
                            child: Icon(Icons.favorite_rounded,
                                color: data.likes.contains(
                                        FirebaseAuth.instance.currentUser!.uid)
                                    ? Colors.red
                                    : Colors.black12),
                          ),
                        );
                      }),
                ),
              ),
              ListTile(
                title: Container(
                  height: 50,
                  child: TextInputField(
                      controller: _commentController,
                      // controller: TextEditingController(),
                      myIcon: Icons.comment,
                      myLabelText: "comment"),
                ),
                trailing: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.black26),
                  width: 60,
                  child: TextButton(
                    onPressed: () {
                      commentController
                          .postComment(_commentController.text.trim());
                    },
                    child: Icon(
                      Icons.send,
                      size: 33,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
