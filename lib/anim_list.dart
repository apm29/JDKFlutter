import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AnimList extends StatefulWidget {

  @override
  State createState() {
    return new AnimListState();
  }
}

class AnimListState extends State<AnimList> {
  ScrollController _controller;
  final GlobalKey<AnimatedListState> _key = new GlobalKey();
  var _list = [1, 2, 3, 4, 5, 6, 7, 8];

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = new ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    var animatedList = new AnimatedList(
      key: _key,
      itemBuilder: (context, index, anim) {
        var item = _list[index];
        return new FadeTransition(
          opacity: anim,
          child: new Card(
            color: Colors.black12,
            child: new Text(item.toString(), textAlign: TextAlign.center,),
          ),
        );
      },
      controller: _controller,
      initialItemCount: _list.length,
    );
    return new MaterialApp(
      home: new Scaffold(
        body: animatedList,
        bottomNavigationBar: new BottomNavigationBar(
          currentIndex: _currentIndex,
          items: [
            new BottomNavigationBarItem(
                icon: new Icon(Icons.add), title: new Text('add')),
            new BottomNavigationBarItem(
                icon: new Icon(Icons.remove), title: new Text('remove')),
          ],
          onTap: (index) {
            update(index);
          },),
      ),
    );
  }

  void update(int index) {
    if (index == 0) {
      //add
      setState(() {
        _list.add(new Random().nextInt(100));
        _key.currentState.insertItem(_list.length-1,duration: new Duration(seconds: 1));
      });
    } else {
      setState(() {
        if (_list.length > 0)
          _list.removeLast();

        _key.currentState.removeItem(_list.length, (BuildContext context,
            Animation<double> animation) {
          return new FadeTransition(
            opacity: animation,
            child: new Card(
              color: Colors.black12,
              child: new Text("", textAlign: TextAlign.center,),
            ),
          );
        });
      });
    }
    _currentIndex = index;
    print(_list);
  }
}