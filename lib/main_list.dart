import 'package:flutter/material.dart';
import 'package:jkd_flutter/theme.dart';
import 'package:jkd_flutter/utils/sp_utils.dart';

class MainListWidget extends StatefulWidget {
  @override
  State createState() {
    return new MainListState();
  }
}

class MainListState extends State<MainListWidget>
    with TickerProviderStateMixin {
  ThemeData _themeData;
  List<String> _list = [
    "Animation",
    "Navigator",
    "List",
    "Widget",
    "Layout",
    "Gesture",
    "Else"
  ];

  AnimationController controller;
  ScrollController scrollController = new ScrollController();
  @override
  void initState() {
    super.initState();
    controller = new AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);
    _initTheme();
  }

  void _initTheme() async {
    var index = await SPUtils.get('themeIndex');
    if (index == null) index = 0;
    _themeData = kAllGalleryThemes[index].theme;
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: _themeData,
      home: new Scaffold(
        appBar: new AppBar(
          centerTitle: true,
          title: new Text("测试列表"),
        ),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    print(_list.length);
    scrollController.addListener(() {
      print("position:" + scrollController.position.pixels.toString());
      print("offset:" + scrollController.offset.toString());
    });
    return new ListView.builder(
      controller: scrollController,
      physics: new BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return new Container(
          height: 200.0,
          child: new Align(child: new Text(_list[index])),
        );
      },
      itemCount: _list.length,
    );
  }
}
