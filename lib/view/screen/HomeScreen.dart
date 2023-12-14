import 'package:flutter/material.dart';
import 'package:tic_tok/constant.dart';
import 'package:tic_tok/view/widget/coustamAddIcon.dart';

class HomeScreen1 extends StatefulWidget {
  const HomeScreen1({Key? key}) : super(key: key);

  @override
  State<HomeScreen1> createState() => _HomeScreen1State();
}

class _HomeScreen1State extends State<HomeScreen1> {
  int pageIdx = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType
                .fixed, //give fix size to bottomNavigationBar item
            onTap: (index) {
              setState(() {
                pageIdx = index;
              });
              // pageIdx = index;
            },
            currentIndex: pageIdx,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    size: 25,
                  ),
                  label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.search,
                    size: 25,
                  ),
                  label: "Search"),
              BottomNavigationBarItem(icon: CoustamAddIcon(), label: ""),
              BottomNavigationBarItem(
                  icon: Icon(Icons.message, size: 25), label: 'Messages'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person, size: 25), label: 'Profile'),
            ]),
        body: Center(
          child: pageIndex[pageIdx],
        ));
  }
}
