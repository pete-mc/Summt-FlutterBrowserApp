import 'package:flutter/material.dart';
import 'package:flutter_browser/webview_tab.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';

import 'models/browser_model.dart';
import 'models/webview_model.dart';

class EmptyTab extends StatefulWidget {
  const EmptyTab({Key? key}) : super(key: key);

  @override
  State<EmptyTab> createState() => _EmptyTabState();
}

class _EmptyTabState extends State<EmptyTab> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var browserModel = Provider.of<BrowserModel>(context, listen: true);
    var settings = browserModel.getSettings();

    return Scaffold(
      backgroundColor: const Color(0xFF00348d), 
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Image(image: AssetImage("assets/images/logo-scouts-terrain-mark.png"), height: 150, width: 150),
            const SizedBox(height: 10),
            const Image(image: AssetImage("assets/images/logo-scouts-terrain-text-inverted.png"), height: 30),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CustomGradientButton(
                  text: "     NEW SESSION    ",
                  gradient: const LinearGradient(
                    colors: <Color>[Color(0xFF030f2b), Color(0xFF04266B)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight 
                  ),
                  onPressed: () {
                    openTerrainTab();
                    FocusScope.of(context).unfocus();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void openNewTab(value) {
    var browserModel = Provider.of<BrowserModel>(context, listen: false);
    var settings = browserModel.getSettings();

    browserModel.addTab(WebViewTab(
      key: GlobalKey(),
      webViewModel: WebViewModel(
          url: WebUri(value.startsWith("http")
              ? value
              : settings.searchEngine.searchUrl + value)),
    ));
  }

    void openTerrainTab () {
    var browserModel = Provider.of<BrowserModel>(context, listen: false);
    browserModel.addTab(WebViewTab(
      key: GlobalKey(),
      webViewModel: WebViewModel(
          url: WebUri('https://terrain.scouts.com.au')),
    ));
  }
}


class CustomGradientButton extends StatelessWidget {
  final Gradient gradient;
  final VoidCallback onPressed;
  final String text;

  const CustomGradientButton({
    Key? key,
    required this.gradient,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.0, // Adjust the height as needed
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(80.0),
            ),
          ),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.all(0.0),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
          overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          minimumSize: MaterialStateProperty.all<Size>(
            const Size(88.0, 36.0),
          ),
          elevation: MaterialStateProperty.all<double>(0.0),
          textStyle: MaterialStateProperty.all<TextStyle>(
            const TextStyle(color: Colors.white, letterSpacing: 1.2),
          ),
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: const BorderRadius.all(Radius.circular(80.0)),
          ),
          child: Container(
            alignment: Alignment.center,
            child: Text(text),
          ),
        ),
      ),
    );
  }
}