import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ProfileButton extends StatelessWidget {
  ProfileButton({super.key, required this.profilePhotoUrl});
  String profilePhotoUrl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      width: 70,
      child: Stack(
        children: [
          Positioned(
              left: 5,
              child: Container(
                width: 60,
                height: 60,
                padding: EdgeInsets.all(1),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(35)),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(35),
                    child: Image(
                      fit: BoxFit.cover,
                      image: NetworkImage(profilePhotoUrl),
                      //   image: NetworkImage(
                      //       "https://img.freepik.com/free-photo/young-caucasian-girl-posing-stylish-neon-light-room_155003-31856.jpg"),
                      //   fit: BoxFit.cover,
                      // ),
                    )),
              ))
        ],
      ),
    );
  }
}
