/*
 Created by Thanh Son on 22/11/2022.
 Copyright (c) 2022 . All rights reserved.
*/

import '../overlay_manager.base.dart';
import 'functions.dart';

///
/// Every overlay is provided an [OverlayManagerEntry].
/// Check the state of overlay by [closed] flag and close it by [close] method.
abstract class OverlayManagerEntry<T> extends Comparable {
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

  /// In development, the [elevation] provides layer position of this overlay in manage
  final double elevation;

  /// [closed] is true if this overlay is closed.
  /// each overlay can be shown only one time and can not be reused if it is closed
  bool get closed;

  /// close this overlay if [closed] is false and return T [value] for [onDismiss]
  void close(T? value);

  @override
  int compareTo(other) {
    if (other is OverlayManagerEntry) {
      return elevation.compareTo(other.elevation);
    }
    return 0;
  }
}
