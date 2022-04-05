import 'package:device_apps/device_apps.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../controller/home_controller.dart';
import '../../utils/constants.dart';

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
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search',
                  helperStyle: Theme.of(context).textTheme.subtitle1
                ),
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
            leading: IconButton(
                onPressed: ()=> Get.back(),
                icon: const Icon(
                  FontAwesomeIcons.arrowLeft,
                  size: 22,
                )),
            actions: [
              IconButton(
                  onPressed: () {

                  },
                  icon: const Icon(
                    FontAwesomeIcons.search,
                    size: 22,
                  )),
            ],
          ),
          drawerScrimColor: Colors.transparent,
          body: Obx(() => controller.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : CupertinoScrollbar(
                  child: ListView.separated(
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider();
                      },
                      itemBuilder: (BuildContext context, int position) {
                        Application app = controller.applicationList[position];

                        return Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 7.5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              (app is ApplicationWithIcon)
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.memory(
                                        app.icon,
                                        height: 60,
                                        width: 60,
                                      ),
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.asset(
                                        appLogo,
                                        height: 60,
                                        width: 60,
                                      ),
                                    ),
                              const SizedBox(
                                width: 15,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width - 90,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      app.appName,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          Theme.of(context).textTheme.headline5,
                                    ),
                                    const Divider(),
                                    Text(
                                      app.packageName,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          Theme.of(context).textTheme.subtitle1,
                                    ),
                                    const Divider(),
                                    Text(
                                      'Version: (${app.versionCode}) ${app.versionName}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                    const Divider(),
                                    Text(
                                      'Installed: ${DateTime.fromMillisecondsSinceEpoch(app.installTimeMillis).toString()}',
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                    ),
                                    const Divider(),
                                    Text(
                                      'Installed: ${DateTime.fromMillisecondsSinceEpoch(app.updateTimeMillis).toString()}',
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                      itemCount: controller.applicationList.length),
                )),
        ),
      ),
    );
  }

  void onAppClicked(BuildContext context, Application app) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(app.appName),
            actions: <Widget>[
              _AppButtonAction(
                label: 'Open app',
                onPressed: () => app.openApp(),
              ),
              _AppButtonAction(
                label: 'Open app settings',
                onPressed: () => app.openSettingsScreen(),
              ),
              _AppButtonAction(
                label: 'Uninstall app',
                onPressed: () async => app.uninstallApp(),
              ),
            ],
          );
        });
  }
}

class _AppButtonAction extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  _AppButtonAction({required this.label, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        onPressed?.call();
        Navigator.of(context).maybePop();
      },
      child: Text(label),
    );
  }
}
