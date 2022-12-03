/*
 Created by Thanh Son on 22/11/2022.
 Copyright (c) 2022 . All rights reserved.
*/
enum OverlayMode {
  /// Overlay entry will have barrier and can be dismissed when out click
  opaque,

  /// Overlay entry will not have barrier and can not be dismissed when out click
  /// Below widget can be touch
  /// The overlay will have Material
  transparent,

  /// Overlay entry will not have barrier and can not be dismissed when out click
  /// Below widget can be touch
  /// The overlay will not have Material
  unknown
}
