import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/scheduler/ticker.dart';
import 'package:http/http.dart' as http;
import 'package:jkd_flutter/model/api/api_interface.dart';
import 'package:jkd_flutter/utils/sp_utils.dart';
import 'package:jkd_flutter/utils/utils.dart';
import 'package:quiver/async.dart';

class LoginWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new LoginState();
  }
}

class LoginState extends State<LoginWidget> implements TickerProvider {
  String userName;
  String smsCode;
  BuildContext context;

  CountdownTimer timer;
  bool inCount = false;
  String sendText = "获取验证码";

  AnimationController controller;
  CurvedAnimation curve;

  @override
  void initState() {
    super.initState();
    controller = new AnimationController(
        duration: const Duration(milliseconds: 5000), vsync: this);
    curve = new CurvedAnimation(parent: controller, curve: Curves.easeIn);

    controller.forward();
  }

  @override
  Ticker createTicker(TickerCallback onTick) {
    return new Ticker(onTick);
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return new Scaffold(
      appBar: new AppBar(title: new Text("Login")),
      body: new Container(
        padding: new EdgeInsets.fromLTRB(22.0, 44.0, 22.0, 11.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new FadeTransition(
              opacity: curve,
              child: new FlutterLogo(
                size: 100.0,
              ),
            ),
            new FlatButton(
              child: new Text(
                '登录',
                style: new TextStyle(fontSize: 22.0),
              ),
              onPressed: () => controller.repeat(),
            ),
            new TextField(
              decoration: new InputDecoration(hintText: '电话Tel'),
              style: new TextStyle(fontSize: 18.0, color: Colors.black),
              onChanged: (txt) {
                userName = txt;
              },
            ),
            new Row(
              children: <Widget>[
                new Expanded(
                    flex: 2,
                    child: new TextField(
                      decoration: new InputDecoration(hintText: '验证码'),
                      style: new TextStyle(fontSize: 18.0, color: Colors.black),
                      onChanged: (txt) {
                        smsCode = txt;
                      },
                    )),
                new RaisedButton(
                  onPressed: inCount ? null : _smsSend,
                  color: Colors.yellow[500],
                  child: new Text(sendText),
                )
              ],
            ),
            new Container(
              padding: new EdgeInsets.fromLTRB(22.0, 44.0, 22.0, 11.0),
            ),
            new RaisedButton(
              onPressed: _login,
              color: Colors.yellow[500],
              padding: new EdgeInsets.fromLTRB(66.0, 11.0, 66.0, 11.0),
              child: new Text(
                "登录",
                style: new TextStyle(fontSize: 18.0),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    if (timer != null) timer.cancel();
  }

  void _smsSend() async {
    if (userName == null || userName.length < 11) {
      await showToast(context, "用户名不正确");
    } else {
      http.Response response = await API.sms(userName);
      Map<String, dynamic> loginResult = json.decode(response.body);
      await showToast(context, loginResult['msg']);
      if (loginResult['code'] == 200) {
        inCount = true;
        timer = new CountdownTimer(
            new Duration(seconds: 60), new Duration(seconds: 1));
        timer.listen((count) {
          setState(() {
            sendText = count.elapsed.inSeconds >= 60
                ? "获取验证码"
                : "(${60 - count.elapsed
                .inSeconds})秒后重发";
            inCount = count.elapsed.inSeconds < 60;
            //print(sendText);
          });
        });
      }
    }
  }

  void _login() async {
    print(API.login_url);
    Map<String, dynamic> baseBean = await login(smsCode, userName);
    showToast(context, baseBean['msg']);
    if (baseBean['data'] != null && baseBean['code'] == 200) {
//      var loginResult =
//          LoginResult.fromJson(json.decode(baseBean.data.toString()));
//      print('login access_token:' + loginResult.access_token);
      Map<String, dynamic> loginResult = baseBean['data'];
      SPUtils.put(API.access_token, loginResult['access_token']);
      print("save_token:" + loginResult['access_token']);
      Navigator.pushNamed(context, '/main');
    }
  }

  Future<Map<String, dynamic>> login(String code, String mobile) async {
    http.Response response = await API.login(mobile, code);
    return json.decode(response.body);
  }
}
