import 'package:flutter/material.dart';
import 'package:jkd_flutter/model/api/api_interface.dart';
import 'package:quiver/async.dart';

class LoginWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new LoginState();
  }
}

class LoginState extends State<LoginWidget> {
  String userName;
  String smsCode;
  BuildContext context;

  CountdownTimer timer;
  bool inCount = false;
  String sendText = "获取验证码";

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
            new Text(
              '登录',
              style: new TextStyle(fontSize: 22.0),
            ),
            new TextField(
              decoration: new InputDecoration(hintText: '用户名'),
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
                      controller: new TextEditingController(),
                      decoration: new InputDecoration(hintText: '验证码'),
                      style: new TextStyle(fontSize: 18.0, color: Colors.black),
                      onChanged: (txt) {
                        smsCode = txt;
                      },

                    )),
                new Expanded(
                    child: new RaisedButton(
                  onPressed: inCount ? null : _smsSend,
                  color: Colors.yellow[500],
                  child: new Text(sendText),
                ))
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
    if (timer != null) timer.cancel();
  }

  void _smsSend() async {
    if (userName == null || userName.length < 11) {
      showToast("用户名不正确");
    } else {
      var loginResult = await API.sendSms(userName);
      showToast(loginResult.msg);
      if (loginResult.isSuccess()) {
        inCount = true;
        timer = new CountdownTimer(
            new Duration(seconds: 60), new Duration(seconds: 1));
        timer.listen((count) {
          setState(() {
            sendText = count.elapsed.inSeconds >= 60
                ? "获取验证码"
                : "(${60-count.elapsed
                .inSeconds})秒后重发";
            inCount = count.elapsed.inSeconds < 60;
            print(sendText);
          });
        });
      }
    }
  }

  void showToast(String text) {
    var simpleDialog = new SimpleDialog(
      children: <Widget>[
        new Text(
          text,
          textAlign: TextAlign.center,
        )
      ],
    );
    showDialog(
        context: context,
        builder: (context) {
          return simpleDialog;
        });
  }

  void _login() async{
    var baseBean = await API.login(smsCode, userName);
    showToast(baseBean.msg);
    print('login');
  }
}
