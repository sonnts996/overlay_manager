import 'package:flutter/material.dart';

import '../models/functions.dart';
import '../models/overlay_manager_entry.dart';
import '../models/overlay_mode.dart';
import '../overlay_manager.base.dart';

class _OverlayManagerEntry<T> extends OverlayManagerEntry<T> {
  _OverlayManagerEntry({
    required OverlayManager manager,
    OverlayDismiss<T>? onDismiss,
    bool isDismissible = true,
    double elevation = 0,
  }) : super(
          manager: manager,
          onDismiss: onDismiss,
          isDismissible: isDismissible,
          elevation: elevation,
        );

  late OverlayEntry _overlay;

  bool _closed = false;

  @override
  bool get closed => _closed;

  @override
  void close([T? value]) {
    if (!closed) {
      _overlay.remove();
      (manager as _OverlayManager)._remove(this);
      _closed = true;
      onDismiss?.call(value);
    }
  }
}

abstract class _OverlayManager extends OverlayManager {
  _OverlayManager(
      {GlobalKey<NavigatorState>? navigatorKey, BuildContext? context})
      : super(
          navigatorKey: navigatorKey,
          context: context,
        );

  OverlayState get _overlay;

  final _entries = <OverlayManagerEntry>[];

  @override
  int get count => _entries.length;

  @override
  void closeAll() {
    if (_entries.isEmpty) {
      return;
    }
    _entries.first.close(null);
    if (_entries.isNotEmpty) {
      closeAll();
    }
  }

  @override
  void pop<T>([OverlayManagerEntry? entry, T? value]) {
    (entry ?? topEntry)?.close(value);
  }

  @override
  OverlayManagerEntry? get topEntry {
    if (_entries.isNotEmpty) {
      return _entries.last;
    }
    return null;
  }

  @override
  OverlayManagerEntry<T> show<T>({
    required OverlayBuilder<T> builder,
    bool isDismissible = true,
    OverlayDismiss<T>? onDismiss,
    Color barrierColor = Colors.black45,
    OverlayMode mode = OverlayMode.opaque,
    double elevation = 0,
  }) {
    final entry = _OverlayManagerEntry<T>(
        manager: this,
        onDismiss: onDismiss,
        isDismissible: isDismissible,
        elevation: elevation);
    entry._overlay = _create<T>(
      builder: builder,
      entry: entry,
      onDismiss: onDismiss,
      isDismissible: isDismissible,
      barrierColor: barrierColor,
      mode: mode,
    );

    if (_entries.length == 1) {
      _entries.add(entry);
      _overlay.insert(entry._overlay);
    } else {
      OverlayManagerEntry? above;
      try {
        above = _entries.firstWhere((element) => element.elevation > elevation);
      } catch (e) {
        above = null;
      }

      if (above == null) {
        _entries.add(entry);
        _overlay.insert(entry._overlay);
      } else {
        final index = _entries.indexOf(above);
        _entries.insert(index, entry);
        _overlay.insert(entry._overlay,
            above: (above as _OverlayManagerEntry)._overlay);
      }
    }
    return entry;
  }

  @override
  void rearrange() {
    _entries.sort((a, b) => a.compareTo(b));
    final newEntries =
        _entries.map((e) => (e as _OverlayManagerEntry)._overlay);
    _overlay.rearrange(newEntries, below: newEntries.first);
  }

  OverlayEntry _create<T>({
    required OverlayBuilder<T> builder,
    required OverlayManagerEntry<T> entry,
    bool isDismissible = true,
    OverlayDismiss<T>? onDismiss,
    Color barrierColor = Colors.black45,
    OverlayMode mode = OverlayMode.opaque,
  }) {
    if (mode == OverlayMode.opaque) {
      void ignoreTab() {
        //todo: this will skip tab event
      }
      return OverlayEntry(
        opaque: false,
        maintainState: true,
        builder: (context) => GestureDetector(
          behavior: HitTestBehavior.deferToChild,
          onTap: !isDismissible ? null : () => entry.close(null),
          child: Material(
            color: barrierColor,
            child: GestureDetector(
              onTap: ignoreTab,
              child: builder.call(context, entry),
            ),
          ),
        ),
      );
    } else if (mode == OverlayMode.transparent) {
      return OverlayEntry(
        opaque: false,
        maintainState: true,
        builder: (context) => Material(
            type: MaterialType.transparency,
            child: builder.call(context, entry)),
      );
    } else {
      return OverlayEntry(
        opaque: false,
        maintainState: true,
        builder: (context) => builder.call(context, entry),
      );
    }
  }

  void _remove(OverlayManagerEntry entry) {
    _entries.remove(entry);
  }
  //
// @override
// void rearrange(Iterable<OverlayManager> orderedList) {
//   if (orderedList.length > 1) {
//     final entry =
//         orderedList.map((e) => _entries).expand((element) => element);
//     _overlay.rearrange(
//       entry.map((e) => (e as _OverlayManagerEntry)._overlay),
//     );
//   }
// }
}

///
/// Create Manager with GlobalKey<NavigatorState> [navigatorKey],
/// commonly used for global managers.
/// Note that each Manager is independent even though it has the same [navigatorKey].
class GlobalOverlayManager extends _OverlayManager {
  /// Create a [OverlayManager] with the Navigator key.
  GlobalOverlayManager({required GlobalKey<NavigatorState> navigatorKey})
      : super(navigatorKey: navigatorKey);

  @override
  OverlayState get _overlay => navigatorKey!.currentState!.overlay!;
}

///
/// Create Manager with BuildContext [context],
/// commonly used for one or a small page group managers.
/// Note that each Manager is independent even though it has the same [context].
class ContextOverlayManager extends _OverlayManager {
  /// Create a [OverlayManager] with the context
  ContextOverlayManager({required BuildContext context})
      : super(context: context);

  @override
  OverlayState get _overlay => Overlay.of(context!);
}
