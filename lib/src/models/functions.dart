/*
 Created by Thanh Son on 22/11/2022.
 Copyright (c) 2022 . All rights reserved.
*/

import 'package:flutter/widgets.dart';

import 'overlay_manager_entry.dart';

///
/// OverlayBuilder returns the overlay a widget to display on the screen,
/// with [context] and an OverlayManagerEntry [entry] to manage the overlay.
typedef OverlayBuilder<T> = Widget Function(
  BuildContext context,
  OverlayManagerEntry<T> entry,
);

///
/// OverlayDismiss is a callback, it is called when overlay is closed and returns a T [result],
/// the [result] may be null when overlay is closed automated by out click or manager.pop
typedef OverlayDismiss<T> = void Function(T? result);
