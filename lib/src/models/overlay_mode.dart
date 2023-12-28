/*
 Created by Thanh Son on 22/11/2022.
 Copyright (c) 2022 . All rights reserved.
*/
///  The Overlay's mode controls the touchable onto the barrier.
enum OverlayMode {
  /// Overlay entry will have a barrier and can be closed when out click.
  opaque,

  /// Overlay entry will not have any barrier and can not be dismissed when out click.
  /// The below widget can be touched but the overlay widget also has a Material as parents.
  transparent,

  /// Overlay entry will not have any barrier and can not be dismissed when out click.
  /// The below widget can be touched and The overlay will not have any Material cover.
  unknown
}
