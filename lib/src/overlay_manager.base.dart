/*
 Created by Thanh Son on 08/11/2022.
 Copyright (c) 2022 . All rights reserved.
*/

import 'package:flutter/material.dart';
import 'package:overlay_manager/src/models/functions.dart';
import 'package:overlay_manager/src/models/overlay_mode.dart';

import 'models/overlay_manager_entry.dart';

/// List overlay entries with be add manage by [OverlayManager]
/// you can split it to manage a group of entries
abstract class OverlayManager {
  final GlobalKey<NavigatorState>? navigatorKey;

  final BuildContext? context;

  /// Can be use [OverlayManager] with [GlobalKey<NavigatorState>] or [BuildContext]
  const OverlayManager({
    this.navigatorKey,
    this.context,
  }) : assert(navigatorKey != null || (context != null),
            "Either navigator or overlay should be not null");

  // void rearrange(Iterable<OverlayManager> orderedList);

  ///
  /// return number of entries this manager manage
  int get count;

  /// dismiss a special [entry] or [topEntry] with value
  void pop<T>([OverlayManagerEntry? entry, T? value]);

  /// dismiss all entries in this manager
  void closeAll();

  /// return top of entry in this manager
  OverlayManagerEntry? get topEntry;

  /// build and show overlay entry in [builder]
  OverlayManagerEntry<T> show<T>({
    required OverlayBuilder builder,
    bool isDismissible = true,
    OverlayDismiss<T>? onDismiss,
    Color barrierColor = Colors.black45,
    OverlayMode mode = OverlayMode.opaque,
    // double elevation = 0,
  });
}
