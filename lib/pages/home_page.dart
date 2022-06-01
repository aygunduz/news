import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news/data/news_services.dart';
import 'package:news/models/articles.dart';
import 'package:news/pages/content_news.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Articles> articles = [];
  var newpageurl;
  var newpageurlToImage;
  var newpagetitle;
  var newpagedescription;
  var newpagecontent;
  @override
  void initState() {
    NewsService.getNews().then((value) {
      setState(() {
        articles = value!;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HABERLER"),
      ),
      body: ListView.builder(
        itemCount: articles.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
              child: Column(
            children: [
              Image.network(articles[index].urlToImage.toString()),
              GestureDetector(
                onTap: () {
                  newpageurl = articles[index].url.toString();
                  newpageurlToImage = articles[index].urlToImage.toString();
                  newpagetitle = articles[index].title.toString();
                  newpagedescription = articles[index].description.toString();
                  newpagecontent = articles[index].content.toString();
                  Get.to(ContentNews(
                    title: newpagetitle,
                    description: newpagedescription,
                    urlToImage: newpageurlToImage,
                    url: newpageurl,
                  ));
                },
                child: ListTile(
                  title: Text(articles[index].title.toString()),
                  subtitle: Text(articles[index].author.toString()),
                ),
              )
            ],
          ));
        },
      ),
    );
  }
}
