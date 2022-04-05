import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'constants.dart';


String generateRandomString(int len) {
  var r = Random();
  const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  return List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
}


void showAboutDialogue(BuildContext context) async {
  return showDialog(
    barrierColor: Colors.black12,
    context: context,
    barrierDismissible: true,
    useSafeArea: true,
    builder: (context) {
      return Center(
        child: Wrap(children: [
          Container(
            clipBehavior: Clip.none,
            margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      spreadRadius: 5,
                      offset: Offset.zero)
                ]),
            child: Column(
              children: [
                const Text(
                  'About',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8,),
                const Divider(thickness: 1,),
                aboutDialogueItem('App Developer:', developerName),
                const Divider(),
                aboutDialogueItem('Designer Name:', designerName),
                const Divider(),
                aboutDialogueItem('App Icon:', "fontawesome.com,\nsvgrepo.com"),
              ],
            ),
          ),
        ]),
      );
    },
  );
}

Widget aboutDialogueItem(String title, String description) {
  return SizedBox(
    height: 30,
    child: Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.none,
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
        const Spacer(),
        Text(
          description,
          style: const TextStyle(
            decoration: TextDecoration.none,
            fontSize: 14,
            color: Colors.black54,
          ),)
      ],
    ),
  );
}

void showRatingDialogue(BuildContext context) async {
  return showDialog(
    barrierColor: Colors.black12,
    context: context,
    barrierDismissible: true,
    useSafeArea: true,
    builder: (context) {
      return Center(
        child: Wrap(children: [
          Container(
            clipBehavior: Clip.none,
            margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      spreadRadius: 5,
                      offset: Offset.zero)
                ]),
            child: Column(
              children: [
                const Text(
                  'Rate The App',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8,),
                const Divider(thickness: 1,),
                const SizedBox(height: 8,),
                const Text(
                  "Please rate the app 5 stars on Google Play to help spread the world!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: RatingBar.builder(
                    initialRating: 1,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => const FaIcon(
                      FontAwesomeIcons.solidStar,
                      color: Color(0xFFF5365C),
                    ),
                    onRatingUpdate: (rating) async{
                      if(rating == 5){
                        Get.back();
                        String url = appLink;
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      }else{
                        Get.back();
                        ScaffoldMessenger.of(context)
                            .showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Thank you for the rating!'),
                          ),
                        );
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ]),
      );
    },
  );
}


Future<bool> onDeletePressed(BuildContext context) async {
  return showDialog(
    barrierColor: Colors.black12,
    context: context,
    barrierDismissible: true,
    useSafeArea: true,
    builder: (context) {
      return Center(
        child: Wrap(children: [
          Container(
            clipBehavior: Clip.none,
            margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      spreadRadius: 5,
                      offset: Offset.zero)
                ]),
            child: Column(
              children: [
                const Text(
                  'Remove all history',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8,),
                const Divider(thickness: 1,),
                const SizedBox(height: 8,),
                const Text(
                  "Are you sure you want to permanently remove all history?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Row(
                    children: [
                      Expanded(
                          child: TextButton(
                            onPressed: ()=>Get.back(result: true),
                            style: TextButton.styleFrom(
                              primary: Colors.redAccent,
                            ),
                            child: const Text(
                              'Delete',
                              //style: TextStyle(fontSize: 30),
                            ),
                          )
                      ),
                      Expanded(
                          child: TextButton(
                            onPressed: ()=>Get.back(result: false),
                            style: TextButton.styleFrom(
                              primary: Colors.black,
                            ),
                            child: const Text(
                              'Cancel',
                              //style: TextStyle(fontSize: 30),
                            ),
                          )
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ]),
      );
    },
  ).then((value) => value ?? false);

}