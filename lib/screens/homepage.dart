import 'dart:ui';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:newscast/screens/local_news_feed.dart';
import 'package:newscast/screens/notifier.dart';
import 'package:newscast/services/news.dart';
import 'package:newscast/services/weather.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webfeed/domain/rss_feed.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

import 'news_details.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
    required this.size,
    this.imageSrc,
  }) : super(key: key);

  final Size size;
  final String? imageSrc;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late RssFeed rss = RssFeed();
  var cel = 0.0;
  var description = 'unknown';
  var place = '';

  TextEditingController controller = TextEditingController();
  Future loadData() async {
    rss = await NewsScrapper.loadRssFeedData();
    NewsScrapper.fetchHeadlines();
    setState(() {});
  }

  void convertToCelsius() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.reload();

    var mains = preferences.getString('main');
    var kelvin = jsonDecode(mains!)['feels_like'] ?? '0.0';
    var weather = preferences.getString('weather') ?? '[{"description":""}]';
    var city = preferences.getString('city') ?? '';
    setState(() {
      cel = (kelvin - 273.15);
      description = jsonDecode(weather)[0]['description']! ?? '';
      place = city;
    });
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  var data = '[]';

  mystuff() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.reload();
    convertToCelsius();
    data = preferences.getString('headlines') ?? '[]';
    //weather = preferences.getString('weather') ?? '[{"description":""}]';
  }

  @override
  void didChangeDependencies() {
    mystuff();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var yourData = context.watch<SharedPreferences?>();
    convertToCelsius();
    data = yourData?.getString('headlines') ?? '[]';

    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.zero,
      children: <Widget>[
        StatefulBuilder(builder: (context, setter) {
          return Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(40.0),
                    bottomRight: Radius.circular(40.0)),
                child: Stack(
                  children: <Widget>[
                    SizedBox(
                        height: widget.size.height / 2.1,
                        child: Image.asset(
                          'assets/sun.jpg',
                          fit: BoxFit.cover,
                        )),
                    Container(
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.transparent, Colors.black45])),
                      height: widget.size.height / 2.1,
                    ),
                    Positioned(
                      top: 50.0,
                      left: 10.0,
                      right: 10.0,
                      bottom: 10.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Spacer(),
                          const SizedBox(
                            height: 40.0,
                          ),
                          InkWell(
                            onTap: () {
                              showBottomSheet(
                                  elevation: 20.0,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(40.0),
                                          topRight: Radius.circular(40.0))),
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20.0)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const SizedBox(
                                              height: 50.0,
                                            ),
                                            const Text(
                                              'Enter City',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w800),
                                            ),
                                            const SizedBox(
                                              height: 20.0,
                                            ),
                                            CupertinoTextField(
                                                controller: controller,
                                                placeholder:
                                                    'Type in name of city'),
                                            const SizedBox(
                                              height: 140.0,
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: SizedBox(
                                                    height: 60.0,
                                                    child: CupertinoButton(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.0),
                                                      child: const Text(
                                                          'Get Weather'),
                                                      onPressed: () async {
                                                        if (controller
                                                            .text.isNotEmpty) {
                                                          WeatherService
                                                              .queryWeather(
                                                                  setter,
                                                                  controller
                                                                      .text);
                                                        }

                                                        Navigator.pop(context);
                                                      },
                                                      color: Colors.blue[700],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 40.0,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                    sigmaX: 20.0, sigmaY: 20.0),
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.black26,
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        'Weather of the day: Search City 🔍',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    )),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 40.0,
                          ),
                          Text(
                            place,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22.0,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Text(cel.round().toString() + '°C',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 40.0,
                                fontWeight: FontWeight.w800,
                              )),
                          Text(description,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 17.0,
                                fontWeight: FontWeight.w300,
                              )),
                          const Spacer(),
                          Row(
                            children: const <Widget>[
                              Text('See more',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                  )),
                              SizedBox(
                                width: 10.0,
                              ),
                              Icon(Icons.arrow_right_alt_sharp,
                                  color: Colors.white)
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
            ],
          );
        }),
        const SizedBox(height: 40.0),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: Row(
            children: const <Widget>[
              Text('Breaking news',
                  style:
                      TextStyle(fontSize: 24.0, fontWeight: FontWeight.w900)),
              Spacer(),
              Text('More', style: TextStyle(fontWeight: FontWeight.w800)),
            ],
          ),
        ),
        const SizedBox(height: 40.0),
        SizedBox(
          height: 280.0,
          child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: json.decode(data).length,
              itemBuilder: (context, index) {
                return BreakingNewsWidget(
                  size: widget.size,
                  pubDate: json.decode(data)[index]['pubDate'],
                  source: json.decode(data)[index]['source_id'],
                  description: json.decode(data)[index]['description'],
                  imageSrc: json.decode(data)[index]['image_url'],
                  author: json.decode(data)[index]['creator']?[0] ?? 'Unknown',
                  content: json.decode(data)[index]['full_description'] ?? '',
                  title: json.decode(data)[index]['title'],
                );
              }),
        ),
        const SizedBox(height: 40.0),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: Row(
            children: const <Widget>[
              Text('Local news',
                  style:
                      TextStyle(fontSize: 24.0, fontWeight: FontWeight.w900)),
              Spacer(),
            ],
          ),
        ),
        const SizedBox(height: 20.0),
        rss.items?.length == null
            ? Center(
                child: Text(
                'You are offline right now, sync again and your local news will appear heer',
                textAlign: TextAlign.center,
              ))
            : ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: rss.items?.length ?? 0,
                itemBuilder: (context, index) {
                  final item = rss.items![index];
                  return RssFeedWidget(
                      link: item.guid!,
                      pubDate: item.pubDate!,
                      title: item.title ?? '',
                      description: item.description ?? '');
                }),
        const SizedBox(
          height: 150.0,
        ),
      ],
    );
  }
}

class RssFeedWidget extends StatelessWidget {
  const RssFeedWidget(
      {Key? key,
      this.title,
      this.description,
      required this.link,
      required this.pubDate})
      : super(key: key);

  final String? title, description;
  final String link;
  final DateTime pubDate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 10.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => LocalNewsFeed(link: link)));
        },
        child: Hero(
          tag: title!,
          child: SizedBox(
            width: 200.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 15.0,
                ),
                Text(title!,
                    //maxLines: 3,
                    //overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontWeight: FontWeight.w800, fontSize: 13.0)),
                const SizedBox(
                  height: 5.0,
                ),
                Html(
                  data: description!,
                ),
                Text(
                    'Published Date: ' +
                        DateFormat('MMM dd, yyyy')
                            .format(DateTime.parse(pubDate.toString())),
                    style: const TextStyle(
                        fontWeight: FontWeight.w300, fontSize: 13.0)),
                const Divider(
                  color: Colors.black38,
                )
              ],
            ),
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
    this.pubDate,
    required this.title,
    required this.content,
    required this.description,
    this.source,
  }) : super(key: key);

  final Size size;
  final String? imageSrc;
  final String? author;
  final String title;
  final String? content;
  final String? source;
  final String? pubDate;
  final String description;

  @override
  Widget build(BuildContext context) {
    String imageAlt =
        'https://durmazz.com/writable/uploads/products/default.jpg';

    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NewsDetails(
                      source: source,
                      title: title,
                      author: author,
                      imageSrc: imageSrc ?? imageAlt,
                      content: content,
                      description: description)));
        },
        child: Hero(
          tag: title,
          child: Material(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.grey[300],
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
                  const SizedBox(
                    height: 15.0,
                  ),
                  Text(title,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.w800)),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Text(
                      DateFormat('MMM dd, yyyy')
                          .format(DateTime.parse(pubDate.toString())),
                      style: const TextStyle(
                          fontWeight: FontWeight.w300, fontSize: 11.5)),
                  Text('By ${author ?? 'Unknown'}',
                      style: const TextStyle(
                          fontWeight: FontWeight.w300, fontSize: 12.0)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
