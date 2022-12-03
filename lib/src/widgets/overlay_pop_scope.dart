/*
 Created by Thanh Son on 22/11/2022.
 Copyright (c) 2022 . All rights reserved.
*/
import 'package:flutter/cupertino.dart';
import 'package:overlay_manager/overlay_manager.dart';

///
/// Overlay in [manager] will be dismissed when pop back
/// if [onOverlayPop] is special, pop back stack will be process in [onOverlayPop]
/// if [onOverlayPop] return true, [onWillPop] will return true
class OverlayPopScope extends StatelessWidget {
  const OverlayPopScope({
    Key? key,
    required this.child,
    this.onOverlayPop,
    required this.manager,
  }) : super(key: key);

  final Widget child;
  final Future<bool> Function(OverlayManagerEntry? entry)? onOverlayPop;
  final OverlayManager manager;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: child,
        onWillPop: () async {
          final topEntry = manager.topEntry;

          if (onOverlayPop != null) {
            return onOverlayPop!(topEntry);
          } else {
            if (topEntry != null) {
              if (topEntry.isDismissible) {
                manager.pop(topEntry);
              }
              return false;
            }
            return true;
          }
        });
  }
}
