import 'package:flutter/material.dart';
import 'package:jkd_flutter/login.dart';
import 'package:jkd_flutter/model/bean/BaseBean.dart';
import 'utils/api_const.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'utils/sp_utils.dart';
import 'dart:convert';
var myApp = new MyApp();
void main() {

  return runApp(myApp);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isFirst = true;
  @override
  Widget build(BuildContext context) {
    if(isFirst) {
      _startTimer(context);
    }
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return new Scaffold(
      body: new Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: new Image.asset("lib/image/splash.png")),
    );
  }

  void _startTimer(BuildContext context) {
    print('start timer : 2000ms');
    new Timer(new Duration(seconds: 2), (){_getProfile(context);});
  }

  void _getProfile(BuildContext context) {
    print('start get profile');
    profile(context);
  }

  void profile(BuildContext context) async {

    final token = await SPUtils.get(access_token);
    final postResp = await http.post(profile_url,
        headers: public_header, body: "{'access_token':$token}");
    try {
      var map = json.decode(postResp.body);
      var baseBean = BaseBean.fromJson(map);
      if (baseBean.isSuccess()) {
        toMain(context);
      } else {
        toLogin(context);
      }
    } catch (e) {
      toLogin(context);
    }
  }

  void toMain(BuildContext context) {
    print('to main');
    isFirst = false;
  }

  void toLogin(BuildContext context) {
    print('to login');
    Navigator.of(context).pop();
    Navigator.of(context).push(
         new MaterialPageRoute(builder: (context) => new LoginWidget())
    );
    isFirst = false;
  }

  @override
  void dispose() {
    super.dispose();
    print('dispose');
  }

  @override
  void deactivate() {
    super.deactivate();
    print('deactivate');
  }

  @override
  void reassemble() {
    super.reassemble();
    print('reassemble');
  }

  @override
  void didUpdateWidget(MyHomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('didUpdateWidget');
  }

  @override
  void initState() {
    super.initState();
    print('initState');
  }

}
