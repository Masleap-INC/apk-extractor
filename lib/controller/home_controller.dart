import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {

  late TextEditingController searchTextController;

  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void onInit() {
    searchTextController = TextEditingController();
    super.onInit();
  }


  void openDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }

  void closeDrawer() {
    scaffoldKey.currentState?.openEndDrawer();
  }

}
