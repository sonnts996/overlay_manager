/*
 Created by Thanh Son on 22/11/2022.
 Copyright (c) 2022 . All rights reserved.
*/

import '../overlay_manager.base.dart';
import 'functions.dart';

///
/// Every overlay is provided an [OverlayManagerEntry].
/// Check the state of overlay by [closed] flag and close it by [close] method.
abstract class OverlayManagerEntry<T> extends Comparable<OverlayManagerEntry> {
  /// The [OverlayManagerEntry]'s constructor
  OverlayManagerEntry({
    required this.manager,
    this.onDismiss,
    this.isDismissible = true,
    this.elevation = 0,
  });

  ///  The [OverlayManager] manages this overlay.
  final OverlayManager manager;

  /// Used for internal! Will call when overlay is closed.
  final OverlayDismiss<T>? onDismiss;

  /// Used for internal! [isDismissible] is true if the overlay can be close automatically.
  final bool isDismissible;

  /// The [elevation] provides the layer's z-index position of this overlay in manage.
  /// Call [OverlayManager.rearrange] or use [OverlayManagerEntry.rearrange] to apply the new overlay elevation order.
  ///
  /// Note: Nothing happens if there is no the [rearrange] function is called.
  double elevation;

  /// Rearrange entry with [newElevation]
  void rearrange(double newElevation) {
    elevation = newElevation;
    manager.rearrange();
  }

  /// [closed] is true if this overlay is closed.
  /// each overlay can be shown only one time and can not be reused if it is closed
  bool get closed;

  /// close this overlay if [closed] is false and return T [value] for [onDismiss]
  void close([T? value]);

  @override
  int compareTo(OverlayManagerEntry other) =>
      elevation.compareTo(other.elevation);
}
