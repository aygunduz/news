import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news/apikeys/apikeys.dart';

import '../models/articles.dart';
import '../models/news.dart';

class NewsService {
  static Future<List<Articles>?> getGeneralNews(listindex) async {
    List<String> urllist = [
      'http://newsapi.org/v2/top-headlines?country=tr&category=general&apiKey=$newsApiKey',
      'https://newsapi.org/v2/top-headlines?country=tr&category=sports&apiKey=$newsApiKey',
      "https://newsapi.org/v2/top-headlines?country=tr&category=business&apiKey=$newsApiKey",
      "https://newsapi.org/v2/top-headlines?country=tr&category=science&apiKey=$newsApiKey",
      "https://newsapi.org/v2/top-headlines?country=tr&category=technology&apiKey=$newsApiKey",
      "https://newsapi.org/v2/top-headlines?country=tr&category=health&apiKey=$newsApiKey",
      "https://newsapi.org/v2/top-headlines?country=tr&category=entertainment&apiKey=e$newsApiKey",
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
