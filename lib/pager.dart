import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newscast/screens/homepage.dart';

class Pager extends StatefulWidget {
  const Pager({Key? key}) : super(key: key);

  @override
  State<Pager> createState() => _PagerState();
}

class _PagerState extends State<Pager> {
  String imageSrc =
      'https://media.npr.org/assets/img/2021/11/29/south-africa-omicron-spread-1-fad450bffa3a1a545b9b1b741eeca83f625272f4-s1100-c50.jpg';

  var navBottomBarItems = const [
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.house_alt_fill), label: 'Home'),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.search_circle_fill), label: 'Discover'),
  ];

  var initPage = 0;

  PageController pageController = PageController();

  void onItemTap(int index) {
    setState(() {
      initPage == index;

      switch (index) {
        case 0:
          pageController.animateToPage(0,
              duration: const Duration(milliseconds: 50),
              curve: Curves.bounceIn);

          break;
        case 1:
          pageController.animateToPage(1,
              duration: const Duration(milliseconds: 50),
              curve: Curves.bounceIn);

          break;
        default:
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Stack(
        children: <Widget>[
          PageView(
            controller: pageController,
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              HomePage(size: size, imageSrc: imageSrc),
              HomePage(size: size, imageSrc: imageSrc),
            ],
          ),
          // Align(
          //     alignment: Alignment.bottomCenter,
          //     child: BottomNavigationBar(
          //         selectedItemColor: Colors.cyan,
          //         unselectedItemColor: Colors.black,
          //         currentIndex: initPage,
          //         onTap: onItemTap,
          //         items: navBottomBarItems)),
        ],
      ),
    );
  }
}
