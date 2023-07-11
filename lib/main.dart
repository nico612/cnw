import 'dart:async';

import 'package:cniao/app.dart';
import 'package:cniao/global.dart';
import 'package:flutter/material.dart';

main()  {
  runZonedGuarded<Future<void>>(() async {
    Gloabl.init().then((value) => {
      runApp(
        App(authenticationRepository: Gloabl.authenticationRepository)
        // const HomeTest()
        )
    });
  }, (error, stackTrace) async {
    String type = "flutter uncaught error";
    debugPrint(type + error.toString() + stackTrace.toString());
  //   // Bugly.initAndroidCrashReport(appId: "8ff1c1e8d8", isDebug: true);
  //   // await Bugly.postException(
  //   //     type: type, error: error.toString(), stackTrace: stackTrace.toString());
  });

}
