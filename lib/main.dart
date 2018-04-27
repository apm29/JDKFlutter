import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jkd_flutter/model/api/api_interface.dart';
import 'package:jkd_flutter/utils/sp_utils.dart';

class MainWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MainState();
  }
}

class MainState extends State<MainWidget> {
  String _token = '';
  int _currentIndex = 0;

  String _buttonText = '立即放款';

  @override
  void initState() {
    super.initState();
    _getToken();
    _getApplication();
    _getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Main Page',
      home: new Scaffold(
        body: _getBody(),
        bottomNavigationBar: new CupertinoTabBar(
          items: _getNavigation(),
          currentIndex: _currentIndex,
          onTap: null,
        ),
        drawer: _getDrawer(),
        endDrawer: _getDrawer(),
      ),
    );
  }

  Column _getBody() {
    if (_currentIndex == 0)
      return new Column(
        children: <Widget>[
          new Banner(
            message: "Banner",
            location: BannerLocation.topStart,
            child: new Image.asset("lib/image/banner.png"),
          ),
          new Expanded(
            child: new Center(
                child: new RaisedButton(
              onPressed: _toApplyInfo,
              child: new Text(_buttonText),
              color: Colors.yellow[600],
            )),
          ),
        ],
      );
    else {
      return new Column(
        children: <Widget>[
          new Banner(
            message: "JKD",
            location: BannerLocation.topStart,
            child: new Container(
              height: 200.0,
              color: Colors.blueGrey[500],
            ),
          ),
          new Expanded(
            child: new Center(
                child: new RaisedButton(
              onPressed: _logout,
              child: new Text("Logout"),
              color: Colors.yellow[600],
            )),
          ),
        ],
      );
    }
  }

  void _getToken() async {
    String token = await SPUtils.get(API.access_token);
    setState(() {
      _token = token;
    });
  }

  List<BottomNavigationBarItem> _getNavigation() {
    List<BottomNavigationBarItem> widgets = [];
    widgets.add(new BottomNavigationBarItem(
        icon: new IconButton(
          padding: EdgeInsets.all(0.0),
          icon: new Icon(
            Icons.account_balance_wallet,
          ),
          onPressed: () {
            setState(() {
              _currentIndex = 0;
            });
          },
          alignment: Alignment.bottomCenter,
        ),
        title: new Text(
          '首页',
          style: new TextStyle(fontSize: 11.0, wordSpacing: 0.0),
        )));
    widgets.add(new BottomNavigationBarItem(
        icon: new IconButton(
          padding: EdgeInsets.all(0.0),
          icon: new Icon(
            Icons.person,
          ),
          onPressed: () {
            setState(() {
              _currentIndex = 1;
            });
          },
          alignment: Alignment.bottomCenter,
        ),
        title: new Text(
          '我的',
          style: new TextStyle(fontSize: 11.0, wordSpacing: 0.0),
        )));
    return widgets;
  }

  void _getProfile() async {
    var response = await API.profile();
    var map = json.decode(response.body);
    if (map['code'] == 200) {}
  }

  void _getApplication() async {
    var response = await API.application();
    var map = json.decode(response.body);
    if (map['code'] == 200) {
      Map<String, dynamic> data = map['data'];
      int status = data['status'];
      setState(() {
        switch (status) {
          case 3:
            _buttonText = "修改信息";
            break;
          case 1:
          case 2:
          case 4:
          case 5:
          case 6:
          case 7:
          case 12:
            _buttonText = "查看信息";
            break;
          default:
            _buttonText = "立即放款";
        }
        print(_buttonText);
      });
    }
  }

  void _toApplyInfo() {}

  _getDrawer() {
    return new Drawer(
      child: new Center(
        child: new Text('This is a drawer'),
      ),
    );
  }

  void _logout() {
    SPUtils.put(API.access_token, '');
  }
}
