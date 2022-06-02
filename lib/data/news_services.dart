import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/articles.dart';
import '../models/news.dart';

class NewsService {
  static NewsService _singleton = NewsService._internal();
  NewsService._internal();

  factory NewsService() {
    return _singleton;
  }

  //Top-headlines api
  static Future<List<Articles>?> getGeneralNews(listindex) async {
    List<String> urllist = [
      'http://newsapi.org/v2/top-headlines?country=tr&category=general&apiKey=f58b94449b4f45b9844a296497a93747',
      'https://newsapi.org/v2/top-headlines?country=tr&category=sports&apiKey=eb64973028fd45088b646d50de91bc0b',
      "https://newsapi.org/v2/top-headlines?country=tr&category=business&apiKey=eb64973028fd45088b646d50de91bc0b",
      "https://newsapi.org/v2/top-headlines?country=tr&category=science&apiKey=eb64973028fd45088b646d50de91bc0b",
      "https://newsapi.org/v2/top-headlines?country=tr&category=technology&apiKey=eb64973028fd45088b646d50de91bc0b",
      "https://newsapi.org/v2/top-headlines?country=tr&category=health&apiKey=eb64973028fd45088b646d50de91bc0b",
      "https://newsapi.org/v2/top-headlines?country=tr&category=entertainment&apiKey=eb64973028fd45088b646d50de91bc0b",
    ];
    final Uri url = Uri.parse(urllist[listindex]);

    final response = await http.get(url);

    if (response.body.isNotEmpty) {
      final responseJson = json.decode(response.body);
      News news = News.fromJson(responseJson);
      return news.articles;
    } else {
      return null;
    }
  }
}
