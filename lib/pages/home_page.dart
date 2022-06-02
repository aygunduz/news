import 'package:flutter/cupertino.dart';
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
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          child: buildDrawer(),
        ),
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
                methodListTile(index)
              ],
            ));
          },
        ),
      ),
    );
  }

  ListView buildDrawer() {
    return ListView(
      children: [
        DrawerHeader(
            child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Color(0xFFB02407)),
          child: Column(
            children: [
              Expanded(
                flex: 9,
                child: Image.network(
                  "https://news.files.bbci.co.uk/ws/img/logos/og/turkce.png",
                ),
              ),
              Container(
                constraints: BoxConstraints(minWidth: 0, maxWidth: 350),
                width: 350,
                color: Colors.white,
                child: Text(
                  "HABERLERSERDAR.COM",
                  style: TextStyle(fontSize: 15),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        )),
        ListTile(
          leading: Icon(Icons.home),
          visualDensity: VisualDensity(horizontal: 4),
          title: Text(
            "Anasayfa",
          ),
        ), //Anasayfa
        ListTile(
          leading: Icon(Icons.directions_run),
          visualDensity: VisualDensity(horizontal: 4),
          title: Text("Spor"),
        ), // Spor
        ListTile(
          leading: Icon(Icons.timeline),
          visualDensity: VisualDensity(horizontal: 4),
          title: Text("Finans"),
        ), // Finans
        ListTile(
          leading: Icon(Icons.settings_input_antenna),
          visualDensity: VisualDensity(horizontal: 4),
          title: Text("Bilim"),
        ),
        ListTile(
          leading: Icon(Icons.devices_other),
          visualDensity: VisualDensity(horizontal: 4),
          title: Text("Teknoloji"),
        ),
        ListTile(
          leading: Icon(Icons.healing),
          visualDensity: VisualDensity(horizontal: 4),
          title: Text("Sağlık"),
        ),
        ListTile(
          leading: Icon(Icons.mood),
          visualDensity: VisualDensity(horizontal: 4),
          title: Text("Eğlence"),
        ),
      ],
    );
  }

  GestureDetector methodListTile(int index) {
    return GestureDetector(
      onTap: () {
        // Constructor for ContentNews
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
    );
  }
}
