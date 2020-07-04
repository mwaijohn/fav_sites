import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ViewSite extends StatefulWidget {
  @override
  _ViewSiteState createState() => _ViewSiteState();
}

class _ViewSiteState extends State<ViewSite> {
  Map site = {};
  final Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    site = ModalRoute.of(context).settings.arguments;
    print(site);
    return Scaffold(
      backgroundColor: Colors.amberAccent[900],
      appBar: AppBar(
        title: Text(site["title"]),
        centerTitle: false,
        backgroundColor: Colors.blue[900],
      ),
      body: WebView(
        initialUrl: site["link"],
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController){
          _controller.complete(webViewController);
        },
      )
    );
  }
}
