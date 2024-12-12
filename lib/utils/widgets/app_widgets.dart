import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:morror_wall/controllers/browser_controller.dart';
import 'package:provider/provider.dart';

Widget popUpMenu({required BuildContext context}) {
  BrowserController browserControllerW =
      Provider.of<BrowserController>(context, listen: false);
  BrowserController browserControllerR =
      Provider.of<BrowserController>(context, listen: true);
  return AlertDialog(
    title: const Text('Select Search Engine'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        RadioListTile(
            value: "https://www.google.com",
            title: const Text(
              "Google",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            groupValue: browserControllerW.mainURL,
            onChanged: (val) {
              browserControllerW.searchEngineBaseURL =
                  "https://www.google.com/search?q=";
              browserControllerR.updateSearchEngine(baseURL: val);
              browserControllerW.webViewController?.loadUrl(
                  urlRequest: URLRequest(
                url: WebUri('https://www.google.com'),
              ));
              Navigator.pop(context);
            }),
        RadioListTile(
            value: "https://in.search.yahoo.com/?fr2=inr",
            title: const Text(
              "yahoo",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            groupValue: browserControllerW.mainURL,
            onChanged: (val) {
              browserControllerW.searchEngineBaseURL =
                  "https://in.search.yahoo.com/search;_ylt=Awr1TU9f21ZnwSAIiIC6HAx.;_ylc=X1MDMjExNDcyMzAwMgRfcgMyBGZyAwRmcjIDcDpzLHY6c2ZwLG06c2ItdG9wBGdwcmlkA2VfRHNNUkc1U0JlTGc2U2VaWTdzdkEEbl9yc2x0AzAEbl9zdWdnAzEwBG9yaWdpbgNpbi5zZWFyY2gueWFob28uY29tBHBvcwMwBHBxc3RyAwRwcXN0cmwDMARxc3RybAM0BHF1ZXJ5A2FheXUEdF9zdG1wAzE3MzM3NDU2Mjg-?p=";
              browserControllerR.updateSearchEngine(baseURL: val);
              browserControllerW.webViewController?.loadUrl(
                  urlRequest: URLRequest(
                url: WebUri('https://in.search.yahoo.com/?fr2=inr'),
              ));
              Navigator.pop(context);
            }),
        RadioListTile(
            value: "https://duckduckgo.com/",
            title: const Text(
              "duckduckgo",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            groupValue: browserControllerW.mainURL,
            onChanged: (val) {
              browserControllerW.searchEngineBaseURL =
                  "https://duckduckgo.com/?t=h_&q=";
              browserControllerR.updateSearchEngine(baseURL: val);
              browserControllerW.webViewController?.loadUrl(
                  urlRequest: URLRequest(
                url: WebUri('https://duckduckgo.com/'),
              ));
              Navigator.pop(context);
            }),
      ],
    ),
  );
}
