import 'dart:async';

import 'package:flutter/material.dart';

class ListViewTestWidget extends StatefulWidget {
  @override
  State createState() {
    return new ListViewState();
  }
}

class Data {
  String content;
  Sink<String> get sink => controller.sink;
  final controller = StreamController<String>();
  Data(this.content);
}

class ListViewState extends State<ListViewTestWidget> {
  List<Data> mData = List.generate(20, (index) {
    return new Data(index.toString());
  });

  double _topMargin = 10.0;
  ScrollController listController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: Theme.of(context),
      home: new Scaffold(
        body: new RefreshIndicator(
          color: Colors.amberAccent,
          child: new GestureDetector(
            onVerticalDragUpdate: _handleScroll,
            onVerticalDragCancel: () {
              print('onVerticalDragCancel');
            },
            onVerticalDragDown: (d) {
              print('onVerticalDragDown');
            },
            onVerticalDragEnd: (d) {
              print('onVerticalDragEnd');
            },
            onVerticalDragStart: (d) {
              print('onVerticalDragStart');
            },
            onHorizontalDragDown: (d) {
              print('onHorizontalDragDown');
            },
            onHorizontalDragEnd: (d) {
              print('onHorizontalDragEnd');
            },
            onHorizontalDragStart: (d) {
              print('onHorizontalDragStart');
            },
            onHorizontalDragUpdate: (d) {
              print('onHorizontalDragUpdate');
            },
            onHorizontalDragCancel: (){
              print('onHorizontalDragCancel');
            },
            behavior: HitTestBehavior.deferToChild,

            child: new ListView.builder(
              itemBuilder: (context, index) {
                return buildListItem(index);
              },
              itemCount: mData.length,
              controller: listController,
            ),
          ),
          onRefresh: _handleRefresh,
        ),
      ),
    );
  }

  Container buildListItem(int index) {
    return new Container(
      height: 100.0,
      color: Colors.black12,
      margin: new EdgeInsets.fromLTRB(10.0, _topMargin, 10.0, 10.0),
      child: new Align(
        alignment: Alignment.center,
        child: new Text(mData[index].content),
      ),
    );
  }

  Future<Null> _handleRefresh() {
    return Future.delayed(Duration(seconds: 2), () {
      setState(() {
        mData.forEach((e) {
          e.content += 'refresed';
        });
      });
    });
  }

  void _handleScroll(DragUpdateDetails details) {
    print(details.delta);
  }
}
