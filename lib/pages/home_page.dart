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

  int listeneneleman = 0;

  void GeneralNews() {
    NewsService.getGeneralNews(listeneneleman).then((value) {
      setState(() {
        articles = value!;
      });
    });
  }

// First start page
  void initState() {
    super.initState();
    GeneralNews();
  }

// Delete last page
  @override
  void deactivate() {
    GeneralNews();
    super.deactivate();
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
              //Image
              Expanded(
                flex: 9,
                child: Image.network(
                  "https://news.files.bbci.co.uk/ws/img/logos/og/turkce.png",
                ),
              ),
              // Image Text
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
        //Anasayfa
        ListTile(
          onTap: () {
            setState(() {
              listeneneleman = 0;
              deactivate();
              initState();
            });
          },
          leading: Icon(Icons.home),
          visualDensity: VisualDensity(horizontal: 4),
          title: Text(
            "Anasayfa",
          ),
        ),
        //Spor
        ListTile(
          onTap: () {
            setState(() {
              listeneneleman = 1;
              print(listeneneleman);
              deactivate();
              initState();
            });
          },
          leading: Icon(Icons.directions_run),
          visualDensity: VisualDensity(horizontal: 4),
          title: Text("Spor"),
        ),
        // Finans
        ListTile(
          onTap: () {
            setState(() {
              listeneneleman = 2;
              deactivate();
              initState();
            });
          },
          leading: Icon(Icons.timeline),
          visualDensity: VisualDensity(horizontal: 4),
          title: Text("Finans"),
        ),
        //Bilim
        ListTile(
          onTap: () {
            setState(() {
              listeneneleman = 3;
              deactivate();
              initState();
            });
          },
          leading: Icon(Icons.settings_input_antenna),
          visualDensity: VisualDensity(horizontal: 4),
          title: Text("Bilim"),
        ),
        //Teknoloji
        ListTile(
          onTap: () {
            setState(() {
              listeneneleman = 4;
              deactivate();
              initState();
            });
          },
          leading: Icon(Icons.devices_other),
          visualDensity: VisualDensity(horizontal: 4),
          title: Text("Teknoloji"),
        ),
        //Sağlık
        ListTile(
          onTap: () {
            setState(() {
              listeneneleman = 5;
              deactivate();
              initState();
            });
          },
          leading: Icon(Icons.healing),
          visualDensity: VisualDensity(horizontal: 4),
          title: Text("Sağlık"),
        ),
        // Eğlence
        ListTile(
          onTap: () {
            setState(() {
              listeneneleman = 6;
              deactivate();
              initState();
            });
          },
          leading: Icon(Icons.mood),
          visualDensity: VisualDensity(horizontal: 4),
          title: Text("Eğlence"),
        ),
      ],
    );
  }

  //
  // List elemanlarını içerik sayfasına yönlendirme!
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
