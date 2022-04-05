
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {

  late TextEditingController searchTextController;
  var scaffoldKey = GlobalKey<ScaffoldState>();

  var applicationList = <Application>[].obs;

  var isLoading = true.obs;


  @override
  void onInit() {
    searchTextController = TextEditingController();
    getApplicationList();
    super.onInit();
  }


  void openDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }

  void closeDrawer() {
    scaffoldKey.currentState?.openEndDrawer();
  }


  void getApplicationList() async{
    isLoading(true);
    applicationList.value = await DeviceApps.getInstalledApplications(
        includeAppIcons: true,
        includeSystemApps: true,
        onlyAppsWithLaunchIntent: false);
    isLoading(false);
  }




}
