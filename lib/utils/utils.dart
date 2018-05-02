import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:quiver/async.dart';

///
/// buildContext 传null时使用Android native方式
///
Future<int> showToast(BuildContext context, String text) async {
  if (context == null) {
    var methodChannel = const MethodChannel("yjw");
    methodChannel.invokeMethod('toast', <String, String>{'text': text});
    return 1;
  }
  var popped = false;
  var simpleDialog = new SimpleDialog(
    children: <Widget>[
      new SimpleDialogOption(
          onPressed: () {
            popped = Navigator.pop(context, text);
          },
          child: new Text(
            text,
            textAlign: TextAlign.center,
          )),
    ],
  );
  const DURATION = 2;
  CountdownTimer timer = new CountdownTimer(
      new Duration(seconds: DURATION), new Duration(seconds: 1));
  showDialog<String>(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return simpleDialog;
    },
  );
  timer.listen((timer) {
    print(timer.elapsed.inSeconds);
    if (timer.elapsed.inSeconds >= DURATION) {
      if (!popped) Navigator.of(context, rootNavigator: true).pop();
    }
  });
  return 0;
}
