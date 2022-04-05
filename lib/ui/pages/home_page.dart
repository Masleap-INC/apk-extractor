import 'package:apk_extractor/ui/components/app_card.dart';
import 'package:apk_extractor/ui/pages/search_page.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';

import '../../controller/home_controller.dart';
import '../../utils/constants.dart';
import '../components/main_drawer.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: mainPageSystemOverlay(Theme.of(context).brightness),
      child: SafeArea(
        child: Scaffold(
          key: controller.scaffoldKey,
          appBar: AppBar(
            elevation: 0.5,
            backgroundColor: Colors.white,
            iconTheme: const IconThemeData(
              color: Colors.black,
            ),
            titleSpacing: 0,
            title: Text(
              appName,
              style: Theme.of(context).textTheme.headline3,
            ),
            //centerTitle: true,
            leading: IconButton(
                onPressed: controller.openDrawer,
                icon: const Icon(
                  FontAwesomeIcons.bars,
                  size: 22,
                )),
            actions: [
              IconButton(
                  onPressed: () {
                    Get.to(() => SearchPage());
                  },
                  icon: const Icon(
                    FontAwesomeIcons.search,
                    size: 22,
                  )),
              IconButton(
                  onPressed: () {
                    Share.share('Hey check out this android app $appLink');
                  },
                  icon: const Icon(
                    FontAwesomeIcons.shareAlt,
                    size: 22,
                  ))
            ],
          ),
          drawerScrimColor: Colors.transparent,
          body: Obx(() => controller.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : Scrollbar(
                  key: UniqueKey(),
                  child: ListView.builder(
                      itemBuilder: (BuildContext context, int position) {
                        Application app = controller.applicationList[position];
                        return AppCard(app: app);
                      },
                      itemCount: controller.applicationList.length),
                )),
          drawer: const MainDrawer(),
        ),
      ),
    );
  }


}
