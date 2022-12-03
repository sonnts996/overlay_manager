/*
 Created by Thanh Son on 22/11/2022.
 Copyright (c) 2022 . All rights reserved.
*/

import '../overlay_manager.base.dart';
import 'functions.dart';

/// Every overlay will be manage by an entry.
abstract class OverlayManagerEntry<T> extends Comparable {
  OverlayManagerEntry({
    required this.manager,
    this.onDismiss,
    this.isDismissible = true,
    this.elevation = 0,
  });

  /// Manager of this entry
  final OverlayManager manager;
  /// call when overlay is dismissed;
  final OverlayDismiss<T>? onDismiss;

  /// [true] is overlay can be dismissed when out click,
  /// it will be ignore in [OverlayMode.transparent] or [OverlayMode.unknown]
  final bool isDismissible;

  /// Elevation of entry on screen
  final double elevation;

  /// [true] if entry is dismissed
  bool get closed;

  /// close the entry
  /// [value] will be return on [onDismiss] function
  void close(T? value);

  @override
  int compareTo(other) {
    if (other is OverlayManagerEntry) {
      return elevation.compareTo(other.elevation);
    }
    return 0;
  }
}
