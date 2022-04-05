import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../utils/constants.dart';

class PrivacyPolicy extends StatelessWidget{
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: Colors.redAccent, size: 22,),
          title: const Text(
            "Privacy Policy",
            style: TextStyle(
                color: Colors.blueGrey, fontWeight: FontWeight.bold),
          ),
          titleSpacing: 0,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(FontAwesomeIcons.arrowLeft)),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: WebView(
              javascriptMode: JavascriptMode.unrestricted,
                initialUrl: privacyPolicyUrl,
              onWebViewCreated: (WebViewController c) {},
            ),
          ),
        ),
      ),
    );
  }
}
