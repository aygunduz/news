import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ContentNews extends StatelessWidget {
  String? url;
  String? title;
  String? urlToImage;
  String? description;
  String? author;
  String? content;

  ContentNews({
    Key? key,
    this.author,
    this.urlToImage,
    this.title,
    this.description,
    this.url,
    this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: WebView(
        initialUrl: url,
      ),
    );
  }
}
