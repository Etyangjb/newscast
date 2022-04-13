import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String imageSrc =
      'https://media.npr.org/assets/img/2021/11/29/south-africa-omicron-spread-1-fad450bffa3a1a545b9b1b741eeca83f625272f4-s1100-c50.jpg';

  var navBottomBarItems = const [
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.house_alt_fill), label: 'Home'),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.search_circle_fill), label: 'Discover'),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.person_alt), label: 'Profile')
  ];

  var initPage = 0;

  void onItemTap(int index) {
    setState(() {
      initPage == index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(40.0),
                bottomRight: Radius.circular(40.0)),
            child: Stack(
              children: <Widget>[
                SizedBox(
                    height: size.height / 2.1,
                    child: Image.network(
                      imageSrc,
                      fit: BoxFit.cover,
                    )),
                Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, Colors.black45])),
                  height: size.height / 2.1,
                ),
                Positioned(
                  top: 50.0,
                  left: 10.0,
                  right: 10.0,
                  bottom: 10.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.black26,
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.menu,
                                      color: Colors.white))),
                        ),
                      ),
                      const SizedBox(
                        height: 40.0,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.black26,
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'News of the day',
                                  style: TextStyle(color: Colors.white),
                                ),
                              )),
                        ),
                      ),
                      const SizedBox(
                        height: 40.0,
                      ),
                      const Text(
                          'V.I.P Immunisation going on massively in Uganda as the spread of the Omicron variant increases',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w800,
                          )),
                      const Spacer(),
                      Row(
                        children: const <Widget>[
                          Text('Lean more',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                              )),
                          SizedBox(
                            width: 10.0,
                          ),
                          Icon(Icons.arrow_right_alt_sharp, color: Colors.white)
                        ],
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: BottomNavigationBar(
                  currentIndex: initPage,
                  onTap: (index) {
                    setState(() {
                      initPage == index;
                    });
                  },
                  items: navBottomBarItems)),
        ],
      ),
    );
  }
}
