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

  Future<void> showOverlay(int id) async {
    manager.show(
      mode: OverlayMode.transparent,
      elevation: id.toDouble(),
      builder: (context, entry) {
        return Bubble(
          id: id,
          entry: entry,
          moveToTop: () {
            entry.rearrange((manager.topEntry?.elevation ?? 0) + 1);
          },
        );
      },
    );
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
                    count++;
                    showOverlay(count);
                  },
                  child: const Text('Show Overlay')),
              const SizedBox(height: 8),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const OverlayPage(),
                        ));
                  },
                  child: const Text('Local Overlay')),
              const SizedBox(height: 8),
              ElevatedButton(
                  onPressed: () {
                    manager.closeAll();
                  },
                  child: const Text('Clear All')),
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
    required this.moveToTop,
    required this.entry,
  }) : super(key: key);

  final int id;
  final OverlayManagerEntry entry;
  final void Function() moveToTop;

  @override
  State<StatefulWidget> createState() {
    return _BubbleState();
  }
}

class _BubbleState extends State<Bubble> {
  double width = 100.0, height = 100.0;
  late Offset position;
  Offset? startPosition;
  late final int _id;

  late final GlobalKey _key;

  @override
  void initState() {
    super.initState();
    _id = widget.id;
    position = Offset(0.0, height - 20);
    _key = GlobalKey();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: position.dx,
          top: position.dy,
          child: GestureDetector(
            onPanDown: (details) {
              startPosition = details.localPosition;
            },
            onPanEnd: (details) {
              startPosition = null;
            },
            child: Draggable(
              key: _key,
              onDragUpdate: (detail) {
                final renderBox =
                    _key.currentContext?.findRenderObject() as RenderBox?;
                if (renderBox == null) return;

                final adjustPosition =
                    detail.globalPosition - (startPosition ?? Offset.zero);
                setState(
                  () => position = Offset(
                    adjustPosition.dx,
                    adjustPosition.dy,
                  ),
                );
              },
              feedback: const SizedBox(),
              child: GestureDetector(
                onDoubleTap: () {
                  widget.moveToTop();
                  setState(() {});
                },
                child: Container(
                  width: width,
                  height: height,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            spreadRadius: 6)
                      ]),
                  child: Center(
                    child: Text("Drag $_id\n${widget.entry.elevation}"),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
