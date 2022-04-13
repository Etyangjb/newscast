import 'dart:ui';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class NewsDetails extends StatelessWidget {
  const NewsDetails(
      {Key? key,
      this.imageSrc,
      this.content,
      required this.description,
      required this.title,
      this.source,
      this.author})
      : super(key: key);

  final String? imageSrc;
  final String? author;
  final String? source;
  final String? content;
  final String? title;
  final String? description;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Hero(
        tag: title!,
        child: Material(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(40.0),
                        bottomRight: Radius.circular(40.0)),
                    child: Stack(
                      children: <Widget>[
                        SizedBox(
                            height: size.height / 1.6,
                            child: ExtendedImage.network(
                              imageSrc!,
                              fit: BoxFit.cover,
                            )),
                        Container(
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [Colors.transparent, Colors.black45])),
                          height: size.height / 1.6,
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
                                  filter: ImageFilter.blur(
                                      sigmaX: 20.0, sigmaY: 20.0),
                                  child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.black26,
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      child: IconButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          icon: const Icon(
                                              Icons.arrow_back_ios_new,
                                              color: Colors.white))),
                                ),
                              ),
                              const Spacer(),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                      sigmaX: 20.0, sigmaY: 20.0),
                                  child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.black26,
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          'Source: $source',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      )),
                                ),
                              ),
                              const SizedBox(
                                height: 40.0,
                              ),
                              Text(title!,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w800,
                                  )),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Text(description!,
                              maxLines: 4,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w300,
                                  )),
                              const SizedBox(
                                height: 30.0,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40.0),
              Padding(
                padding:
                    const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 30.0),
                child: Text(
                  'Published: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Text(content!),
              ),
              const SizedBox(height: 40.0),
              Padding(
                padding:
                    const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 30.0),
                child: Text(
                  'Category: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 30.0),
                child: Text(
                  'Key: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 150.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BreakingNewsWidget extends StatelessWidget {
  const BreakingNewsWidget({
    Key? key,
    required this.size,
    this.imageSrc,
    this.author,
    required this.title,
    required this.content,
    this.source,
  }) : super(key: key);

  final Size size;
  final String? imageSrc;
  final String? author;
  final String title;
  final String content;
  final String? source;

  @override
  Widget build(BuildContext context) {
    String imageAlt =
        'https://media.npr.org/assets/img/2021/11/29/south-africa-omicron-spread-1-fad450bffa3a1a545b9b1b741eeca83f625272f4-s1100-c50.jpg';

    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: SizedBox(
        width: 200.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: SizedBox(
                  height: size.height / 5.5,
                  child: ExtendedImage.network(
                    imageSrc ?? imageAlt,
                    fit: BoxFit.cover,
                  )),
            ),
            SizedBox(
              height: 15.0,
            ),
            Text(title,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.w800)),
            const SizedBox(
              height: 5.0,
            ),
            Text('4 hrs ago',
                style: const TextStyle(
                    fontWeight: FontWeight.w300, fontSize: 11.5)),
            Text('By ${author ?? 'Unknown'}',
                style: const TextStyle(
                    fontWeight: FontWeight.w300, fontSize: 12.0)),
          ],
        ),
      ),
    );
  }
}
