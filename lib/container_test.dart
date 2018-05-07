import 'package:flutter/material.dart';

class ContainerTestWidget extends StatefulWidget {

  @override
  State createState() {
    return new ContainerState();
  }
}

class ContainerState extends State<ContainerTestWidget> {

  @override
  Widget build(BuildContext context) {
    return new Column(

      children: <Widget>[
        new Container(
          constraints: new BoxConstraints.expand(
            height: 200.0,
          ),
          padding: const EdgeInsets.all(28.0),

          alignment: Alignment.center,
          child: new Text('Hello World', style: Theme
              .of(context)
              .textTheme
              .display1
              .copyWith(color: Colors.white)),
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new NetworkImage(
                  'http://www.wallpapers.oftudo.com/wp-content/uploads/2016/12/papel-de-parede-arvore-banco-480x300.jpg'),
              centerSlice: new Rect.fromLTRB(270.0, 180.0, 540.0, 360.0),
            ),
          ),
          transform: new Matrix4.rotationZ(0.2),
        ),
        new Container(
            margin: const EdgeInsets.all(0.0),
            color: Colors.lightGreen,
            height: 48.0,
          ),

      ],
    )
    ;
  }
}