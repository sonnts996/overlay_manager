/*
 Created by Thanh Son on 22/11/2022.
 Copyright (c) 2022 . All rights reserved.
*/

import 'package:flutter/widgets.dart';

import 'overlay_manager_entry.dart';

///
/// return overlay widget with entry manager
typedef OverlayBuilder = Widget Function(
  BuildContext context,
  OverlayManagerEntry entry,
);

///
/// Call on overlay dismissed
/// entry.close(T) for result
typedef OverlayDismiss<T> = void Function(T? result);
