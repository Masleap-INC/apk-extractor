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
              : CupertinoScrollbar(
                  child: ListView.builder(
                      // separatorBuilder: (BuildContext context, int index) {
                      //   return const Divider();
                      // },
                      itemBuilder: (BuildContext context, int position) {
                        Application app = controller.applicationList[position];

                        return Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {},
                            borderRadius: BorderRadius.circular(5.0),
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 8),
                              //height: 100,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.1),
                                      spreadRadius: 3,
                                      blurRadius: 5,
                                      offset: const Offset(0, 2),
                                    )
                                  ]
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.1),
                                          borderRadius:
                                          BorderRadius.circular(5.0),
                                        ),
                                        child: (app is ApplicationWithIcon)
                                            ? Image.memory(
                                              app.icon,
                                              height: 60,
                                              width: 60,
                                            ) : Image.asset(
                                              appLogo,
                                              height: 60,
                                              width: 60,
                                            ),
                                      ),
                                      Expanded(
                                          flex: 4,
                                          child: SizedBox(
                                            height: 70,
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(child: Text(
                                                      app.appName,
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                      style: Theme.of(context).textTheme.headline4
                                                    ),),
                                                    Padding(
                                                      padding: const EdgeInsets.symmetric(horizontal: 5),
                                                      child: Material(
                                                        color: Colors.transparent,
                                                        child: InkWell(
                                                          onTap: (){

                                                          },
                                                          borderRadius: BorderRadius.circular(5.0),
                                                          child: Container(
                                                            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                                                            decoration: BoxDecoration(
                                                              color: scaffoldBackgroundLight,
                                                              borderRadius: BorderRadius.circular(5.0),
                                                            ),
                                                            child: const Icon(
                                                              FontAwesomeIcons.ellipsisH
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    )


                                                  ],
                                                ),
                                                Container(
                                                  width: double.infinity,
                                                  padding:
                                                  const EdgeInsets.all(5),
                                                  margin:
                                                  const EdgeInsets.fromLTRB(0, 5, 5, 0),
                                                  decoration: BoxDecoration(
                                                    color: Colors.blueGrey,
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        5.0),
                                                  ),
                                                  child: Text(
                                                    app.packageName,
                                                    maxLines: 2,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )),
                                    ],
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    margin: const EdgeInsets.all(5),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.grey
                                          .withOpacity(0.1),
                                      borderRadius:
                                      BorderRadius.circular(5.0),
                                    ),
                                    child: Text(
                                        'Version: (${app.versionCode}) ${app.versionName}\n'
                                            'Installed: ${DateTime.fromMillisecondsSinceEpoch(app.installTimeMillis).toString()}\n'
                                            'Installed: ${DateTime.fromMillisecondsSinceEpoch(app.updateTimeMillis).toString()}',
                                    ),
                                  ),

                                  Row(
                                    children: [
                                      actionButton(
                                        title: 'Open',
                                        onPressed: () {
                                          app.openApp();
                                        }
                                      ),
                                      actionButton(
                                          title: 'Setting',
                                          onPressed: () {
                                            app.openSettingsScreen();
                                          }
                                      ),
                                      actionButton(
                                          title: 'Extract',
                                          onPressed: () {

                                          }
                                      ),
                                    ],
                                  )

                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: controller.applicationList.length),
                )),
          drawer: const MainDrawer(),
        ),
      ),
    );
  }

  Widget actionButton({String? title, VoidCallback? onPressed}) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(5.0),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            decoration: BoxDecoration(
              color: scaffoldBackgroundLight,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Column(
              children: [
                Text(
                  title!,
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
