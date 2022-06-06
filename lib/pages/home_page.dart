import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news/pages/content_news.dart';
import 'package:share_plus/share_plus.dart';

import '../data/news_services.dart';
import '../models/articles.dart';
import '../models/choose_city.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Articles> articles = [];
  int listeneneleman = 0;
  Color? tilecolor = Colors.red;
  String chooseCity = "";
  double? temp;
  List<String> city = City().city;

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
        body: Column(
          children: [
            //Weather Menu
            Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //CHOOSE CITY
                      DropdownButton(
                        dropdownColor: Colors.white,
                        hint: Text(
                          "Bir Şehir Seçiniz",
                          style: TextStyle(color: Colors.black),
                        ),
                        value: chooseCity.isNotEmpty ? chooseCity : null,
                        onChanged: (newValue) {
                          setState(() {
                            chooseCity = newValue.toString();
                            print(chooseCity);
                          });
                        },
                        items: city.map((value) {
                          return DropdownMenuItem(
                              value: value, child: Text(value));
                        }).toList(),
                      ),
                      //DEGREE
                      Text("35", style: TextStyle(color: Colors.black)),
                      //DURUM
                      Text("GÜNEŞLİ", style: TextStyle(color: Colors.black)),
                      //ICON
                      Icon(Icons.cloud, color: Colors.black),
                    ],
                  ),
                )),
            //Content Menu
            Expanded(
              flex: 27,
              child: ListView.builder(
                itemCount: articles.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                      color: Colors.black,
                      margin: EdgeInsets.only(left: 8, right: 8, bottom: 15),
                      child: Column(
                        children: [
                          Image.network(articles[index].urlToImage.toString()),
                          methodListTile(index)
                        ],
                      ));
                },
              ),
            ),
            //Slider Menu
            Expanded(
              flex: 2,
              child: ListView(
                itemExtent: 100,
                scrollDirection: Axis.horizontal,
                children: [
                  //Anasayfa
                  buildListTile(0, "ANASAYFA"),

                  //Spor
                  buildListTile(1, "SPOR"),

                  // Finans
                  buildListTile(2, "FİNANS"),

                  //Bilim
                  buildListTile(3, "BİLİM"),

                  //Teknoloji
                  buildListTile(4, "TEKNOLOJİ"),

                  //Sağlık
                  buildListTile(5, "SAĞLIK"),

                  // Eğlence
                  buildListTile(6, "EĞLENCE"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //Slider Mengu
  ListTile buildListTile(int eleman, String string) {
    return ListTile(
      onTap: () {
        setState(() {
          listeneneleman = eleman;
          deactivate();
          initState();
        });
      },
      tileColor: (listeneneleman == eleman ? Colors.redAccent : tilecolor),
      title: Text(
        "$string",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 13, color: Colors.white),
      ),
    );
  }

  // List elemanlarını içerik sayfasına yönlendirme!
  GestureDetector methodListTile(int index) {
    return GestureDetector(
      onTap: () {
        Get.to(ContentNews(
          title: articles[index].title.toString(),
          url: articles[index].url.toString(),
        ));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        ),
        child: ListTile(
          title: Text(
            articles[index].title.toString(),
            style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 23),
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(top: 18),
                width: 85,
                height: 30,
                child: FloatingActionButton.extended(
                  backgroundColor: Colors.green,
                  onPressed: () {
                    Share.share(
                        "BU HABERİ GÖRMELİSİN ! \n\n\n${articles[index].url.toString()}");
                  },
                  label: Text(
                    "PAYLAŞ",
                    style: TextStyle(fontSize: 11),
                  ),
                  icon: Icon(
                    Icons.send,
                    size: 20,
                  ),
                ),
              ),
              Text(
                articles[index].author.toString(),
                style: TextStyle(
                    color: Colors.red[900], fontWeight: FontWeight.bold),
                textAlign: TextAlign.right,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
