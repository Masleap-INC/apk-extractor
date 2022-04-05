import 'package:device_apps/device_apps.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../controller/home_controller.dart';
import '../../utils/constants.dart';
import '../components/app_card.dart';

class SearchPage extends StatelessWidget {
  SearchPage({Key? key}) : super(key: key);

  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: mainPageSystemOverlay(Theme.of(context).brightness),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0.5,
            backgroundColor: Colors.white,
            iconTheme: const IconThemeData(
              color: Colors.black,
            ),
            titleSpacing: 0,
            title: Container(
              alignment: Alignment.centerLeft,
              color: Colors.white,
              child: TextField(
                controller: controller.searchTextController,
                textInputAction: TextInputAction.search,
                maxLines: 1,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search',
                    helperStyle: Theme.of(context).textTheme.headline4),
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            leading: IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(
                  FontAwesomeIcons.arrowLeft,
                  size: 22,
                )),
          ),
          drawerScrimColor: Colors.transparent,
          body: Obx(() => controller.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : Scrollbar(
                  key: UniqueKey(),
                  child: ListView.builder(
                      itemBuilder: (BuildContext context, int position) {
                        Application app = controller.filteredApplicationList[position];
                        return AppCard(app: app);
                      },
                      itemCount: controller.filteredApplicationList.length),
                )),
        ),
      ),
    );
  }
}
