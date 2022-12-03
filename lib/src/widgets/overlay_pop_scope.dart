/*
 Created by Thanh Son on 22/11/2022.
 Copyright (c) 2022 . All rights reserved.
*/
import 'package:flutter/cupertino.dart';
import 'package:overlay_manager/overlay_manager.dart';

///
/// The first overlay in [manager] will be dismissed when [onBackPressed] or [maybePop] with [onOverlayPop] is null.
/// if [onOverlayPop] is special, the behavior will be processed in [onOverlayPop]
/// if [onOverlayPop] returns true, [onWillPop] will return true, and otherwise false.
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
