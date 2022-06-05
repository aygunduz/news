import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ContentNews extends StatelessWidget {
  String? url;
  String? title;

  ContentNews({
    Key? key,
    this.title,
    this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WebViewController? _myController;
    final Completer<WebViewController> _controller =
        Completer<WebViewController>();
    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.green,
        onPressed: () {
          Share.share("BU HABERİ GÖRMELİSİN! \n \n $url ");
        },
        label: Text("PAYLAŞ"),
        icon: Icon(Icons.send),
      ),
      body: WebView(
        initialUrl: url,
        zoomEnabled: true,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (controller) {
          _controller.complete(controller);
          _myController = controller;
        },
        onPageFinished: (url) {
          _myController!.runJavascript(
            "document.getElementsByClassName('header')[0].style.display='none';",
          );
        },
      ),
    );
  }
}
