import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';


class HowToUseScreen extends StatelessWidget {
  HowToUseScreen({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("How to use "),
        centerTitle: true,
      ),

      body: InAppWebView(
        initialUrlRequest: URLRequest(
            url: Uri.parse('https://youtu.be/h_N2xLjZj5Q')),
        onWebViewCreated: (InAppWebViewController controller) {},
        onProgressChanged: (InAppWebViewController controller, int progress) {},
      ),
    );
  }
}
