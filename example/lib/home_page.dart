/*
 Created by Thanh Son on 22/11/2022.
 Copyright (c) 2022 . All rights reserved.
*/
import 'package:example/main.dart';
import 'package:example/overlay_page.dart';
import 'package:flutter/material.dart';
import 'package:overlay_manager/overlay_manager.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int count = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Overlay Manager'),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    manager.show(
                      mode: OverlayMode.transparent,
                      builder: (context, entry) {
                        count++;
                        return Bubble(id: count);
                      },
                    );
                  },
                  child: const Text('Show Overlay')),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const OverlayPage(),
                        ));
                  },
                  child: const Text('Local Overlay'))
            ]),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class Bubble extends StatefulWidget {
  const Bubble({
    Key? key,
    required this.id,
  }) : super(key: key);

  final int id;

  @override
  State<StatefulWidget> createState() {
    return _BubbleState();
  }
}

class _BubbleState extends State<Bubble> {
  double width = 100.0, height = 100.0;
  late Offset position;
  late final int _id;

  @override
  void initState() {
    super.initState();
    _id = widget.id;
    position = Offset(0.0, height - 20);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          left: position.dx,
          top: position.dy - height + 20,
          child: Draggable(
            child: GestureDetector(
              onTap: () => print('pressed'),
              child: Container(
                width: width,
                height: height,
                color: Colors.blue,
                child: Center(
                  child: Text("Drag $_id"),
                ),
              ),
            ),
            feedback: Material(
              child: Container(
                child: Center(
                  child: Text("Drag $_id"),
                ),
                color: Colors.red[800],
                width: width,
                height: height,
              ),
            ),
            onDraggableCanceled: (Velocity velocity, Offset offset) {
              setState(() => position = offset);
            },
          ),
        ),
      ],
    );
  }
}
