/*
 Created by Thanh Son on 08/11/2022.
 Copyright (c) 2022 . All rights reserved.
*/

import 'package:flutter/material.dart';

import 'models/functions.dart';
import 'models/overlay_manager_entry.dart';
import 'models/overlay_mode.dart';

/// Overlays can be grouped and managed by an OverlayManager.
// [show]  creates and automatically adds into managers.
// The Overlay can be closed by [OverlayManagerEntry.close] or automatically closed by [pop], [closeAll].
abstract class OverlayManager {
  /// OverlayManager can be used with [GlobalKey<NavigatorState>] or [BuildContext].
  /// One and only one in [navigatorKey] or [context] is special.
  const OverlayManager({
    this.navigatorKey,
    this.context,
  }) : assert(navigatorKey != null || (context != null),
            'Either navigator or overlay should be not null');

  final GlobalKey<NavigatorState>? navigatorKey;

  final BuildContext? context;

  // void rearrange(Iterable<OverlayManager> orderedList);

  ///
  /// The number of entries in this manager.
  int get count;

  /// Close a special [entry] or [topEntry] with  a [value] for onDismiss.
  void pop<T>([OverlayManagerEntry? entry, T? value]);

  /// Close all entries in this manager.
  void closeAll();

  /// The top entry in this manager, null if this entries list in the manager is empty.
  OverlayManagerEntry? get topEntry;

  /// Rearrange the entries in this manager by elevation
  void rearrange();

  /// Every time [show] is called, an overlay will be created and displayed on the screen with [elevation].
  /// The widget will be taken from [builder].
  /// If [mode] is equal to [OverlayMode.opaque], [barrierColor] will be applied.
  /// [onDismiss] is called when the overlay is closed.
  /// [isDismissible] equals true to close the overlay automatically.
  /// Note that the overlay cannot be closed by out click if [mode] is different from [OverlayMode.opaque],
  /// then the widgets below are touchable.
  OverlayManagerEntry<T> show<T>({
    required OverlayBuilder<T> builder,
    bool isDismissible = true,
    OverlayDismiss<T>? onDismiss,
    Color barrierColor = Colors.black45,
    OverlayMode mode = OverlayMode.opaque,
    double elevation = 0,
  });
}
