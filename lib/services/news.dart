import 'package:newscast/constants/secrets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webfeed/domain/rss_feed.dart';

class NewsScrapper {
  NewsScrapper._();
  static void fetchHeadlines() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = Uri.parse(
        'https://newsdata.io/api/1/news?apikey=$newsDataApi&language=en');

    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body)['results'];

      prefs.setString('headlines', json.encode(jsonResponse));
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  static loadRssFeedData() async {
    try {
      // This is an open REST API endpoint for testing purposes

      final response = await http.get(Uri.parse(rssFeed));
      var channel = RssFeed.parse(response.body);

      return channel;
    } catch (err) {
      rethrow;
    }
  }
}

class BreakingNews {
  final String? author;
  final String? title;
  final String? description;
  final String? content;
  final String? imageUrl;

  const BreakingNews(
      {this.author, this.title, this.content, this.description, this.imageUrl});

  factory BreakingNews.fromJson(Map<String, dynamic> json) {
    return BreakingNews(
        author: json['creator'][0],
        title: json['title'],
        content: json['full_description'],
        description: json['description'],
        imageUrl: json['image_url']);
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "author": author,
      "title": title,
      "full_description": content,
      "description": description,
      "image_url": imageUrl ??
          'https://media.npr.org/assets/img/2021/11/29/south-africa-omicron-spread-1-fad450bffa3a1a545b9b1b741eeca83f625272f4-s1100-c50.jpg'
      //"name": name,
    };

    return map
      ..removeWhere((String key, dynamic value) =>
          key.isEmpty || value == null || value == '');
  }
}
