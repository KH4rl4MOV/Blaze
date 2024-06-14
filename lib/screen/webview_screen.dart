import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_screen.dart';
import 'welcome_screen.dart';

class WebViewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: Uri.parse("https://tofuzaleg.beget.app/blaze")),
        onWebViewCreated: (controller) {
          controller.addJavaScriptHandler(handlerName: "buttonClicked", callback: (args) async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            bool userHasData = prefs.containsKey('name') && prefs.getString('name')!.isNotEmpty;

            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => userHasData ? HomeScreen() : WelcomeScreen()),
            );
          });
        },
        onLoadStop: (controller, url) async {
          await controller.evaluateJavascript(source: """
            document.getElementById('start-button').onclick = function() {
              window.flutter_inappwebview.callHandler('buttonClicked');
            };
          """);
        },
      ),
    );
  }
}
