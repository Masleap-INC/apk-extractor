import 'dart:io';

import 'package:device_apps/device_apps.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../utils/constants.dart';
import '../../utils/extensions.dart';

class AppCard extends StatelessWidget {
  final Application app;

  const AppCard({Key? key, required this.app}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          showMenuDialogue(context, app);
        },
        borderRadius: BorderRadius.circular(5.0),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
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
              ]),
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
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: (app is ApplicationWithIcon)
                        ? Image.memory(
                            (app as ApplicationWithIcon).icon,
                            height: 60,
                            width: 60,
                          )
                        : Image.asset(
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(app.appName,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {
                                        showMenuDialogue(context, app);
                                      },
                                      borderRadius: BorderRadius.circular(5.0),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 2, horizontal: 10),
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        child: const Icon(
                                            FontAwesomeIcons.ellipsisH),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(5),
                              margin: const EdgeInsets.fromLTRB(0, 5, 5, 0),
                              decoration: BoxDecoration(
                                color: Colors.blueGrey,
                                borderRadius: BorderRadius.circular(5.0),
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
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(5.0),
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
                      context: context,
                      title: 'Open',
                      onPressed: () {
                        app.openApp();
                      }),
                  actionButton(
                      context: context,
                      title: 'Setting',
                      onPressed: () {
                        app.openSettingsScreen();
                      }),
                  actionButton(
                      context: context,
                      title: 'Extract',
                      onPressed: () {
                        checkStoragePermission(app);
                      }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget actionButton(
      {required BuildContext context, String? title, VoidCallback? onPressed}) {
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
              color: Theme.of(context).scaffoldBackgroundColor,
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

  void checkStoragePermission(Application application) async {
    await Permission.storage.request();

    PermissionStatus status = await Permission.storage.status;

    if (status == PermissionStatus.granted) {
      // Extraction code
      Directory? directory;
      try {
        directory = Directory('/storage/emulated/0/Download/ApkExtractor');
        if (!await directory.exists()) {
          directory.createSync(recursive: true);
        }
      } catch (err) {
        if (kDebugMode) {
          print("Cannot get download folder path");
        }
      }

      String? path =
          directory?.path; // (await getExternalStorageDirectory())!.path;
      String fileName = '${application.appName}_${application.versionName}.apk';
      File file = File(app.apkFilePath);

      await file.exists();

      try{
        file.copy('$path/$fileName').then((value) {
          showMessage('File saved into the directory: $value');
        });
      }catch (err) {
        showMessage('Error: $err');
      }
    } else if (status == PermissionStatus.denied ||
        status == PermissionStatus.restricted) {
      showMessage('Please grant storage permission');
    }
  }
}
