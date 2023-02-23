import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class MyBrowserApp extends StatefulWidget {
  const MyBrowserApp({super.key});

  @override
  _MyBrowserAppState createState() => _MyBrowserAppState();
}

class _MyBrowserAppState extends State<MyBrowserApp> {
  InAppWebViewController? webView;
  String url = "";
  double progress = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("InAppWebView Example"),
        ),
        body: Column(children: <Widget>[
          Container(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              onSubmitted: (url) => submitUrl(url),
              textInputAction: TextInputAction.go,
              decoration: const InputDecoration(
                labelText: "Enter a URL",
                hintText: "e.g. https://flutter.dev",
              ),
            ),
          ),
          Row(
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  webView!.goBack();
                },
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward_ios),
                onPressed: () {
                  webView!.goForward();
                },
              ),
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {
                  webView!.reload();
                },
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(10.0),
            child: progress < 1.0
                ? LinearProgressIndicator(value: progress)
                : Container(),
          ),
          Expanded(
            child: InAppWebView(
              initialUrlRequest:
                  URLRequest(url: Uri.parse("https://github.com/flutter")),
              onWebViewCreated: (InAppWebViewController controller) {
                webView = controller;
              },
              onLoadStart: (InAppWebViewController controller, Uri? url) {
                setState(() {
                  this.url = url.toString();
                });
              },
              onProgressChanged:
                  (InAppWebViewController controller, int progress) {
                setState(() {
                  this.progress = progress / 100;
                });
              },
            ),
          ),
        ]),
      ),
    );
  }

  void submitUrl(String url) async {
    if (webView != null && await webView!.canGoBack()) {
      webView!.stopLoading();
    }
    webView!.loadUrl(urlRequest: URLRequest(url: Uri.parse(url)));
  }
}
