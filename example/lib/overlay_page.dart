/*
 Created by Thanh Son on 22/11/2022.
 Copyright (c) 2022 . All rights reserved.
*/

import 'package:flutter/material.dart';
import 'package:overlay_manager/overlay_manager.dart';

class OverlayPage extends StatefulWidget {
  const OverlayPage({
    Key? key,
  }) : super(key: key);

  @override
  State<OverlayPage> createState() => _OverlayPageState();
}

class _OverlayPageState extends State<OverlayPage> {
  late final OverlayManager _manager;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _manager = ContextOverlayManager(context: context);
    });
  }

  @override
  void dispose() {
    _manager.closeAll();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Local Overlay'),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    _manager.show(
                      barrierColor: Colors.red.shade500.withOpacity(0.2),
                      onDismiss: print,
                      isDismissible: false,
                      builder: (context, entry) => AlertMessage(
                        onClose: () => entry.close(0),
                      ),
                    );
                  },
                  child: const Text('Show Overlay'))
            ]),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class AlertMessage extends StatelessWidget {
  const AlertMessage({Key? key, required this.onClose}) : super(key: key);

  final void Function() onClose;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 100,
          width: 300,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Text(
            'Hello, this is a widget on overlay manage by OverlayManager!',
            textAlign: TextAlign.justify,
          ),
        ),
        const SizedBox(height: 16),
        InkWell(
          onTap: onClose,
          child: Ink(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  color: Colors.black45,
                  borderRadius: BorderRadius.circular(25)),
              child: const Icon(
                Icons.close,
                size: 24,
                color: Colors.white,
              )),
        )
      ],
    );
  }
}
