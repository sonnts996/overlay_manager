# Overlay Manager

[![version](https://img.shields.io/pub/v/overlay_manager)](https://pub.dev/packages/overlay_manager) [![license](https://img.shields.io/github/license/sonnts996/overlay_manager)](https://pub.dev/packages/overlay_manager/license)

Group and manage easily flutter overlays: 
- Create a new overlay with the barrier options
- Arrange it in z-index order.
- Check, close, and capture the return value when closed.

## Getting started

```yaml
dependencies:
  objectx: '1.0.3'
```

## Usage

```dart
import 'package:overlay_manager/overlay_manager.dart';
```

The ``GlobalOverlayManager`` helps you create and manage your overlay without context:

```dart

final navKey = GlobalKey<NavigatorState>();
final manager = GlobalOverlayManager(navigatorKey: navKey);
// ...

@override
Widget build(BuildContext context) {
  return MaterialApp(
    navigatorKey: navKey,
    // ...
  );
}
```

or uses the ``ContextOverlayManager``:

```dart
final manager = ContextOverlayManager(context: context);
```

### Show an overlay

- For show an overlay:

```dart
final myEntry = manager.show(
  barrierColor: Colors.red.shade500.withOpacity(0.2),
  onDismiss: print,
  isDismissible: false,
  builder: (context, entry) => AlertMessage(
    onClose: () => entry.close(0),
  ),
);
```

call ``` myEntry.close(0) ``` to close this overlay with the returns value

- If you want to close all overlay when the screen is disposed, let's try:

```dart
@override
void dispose() {
    manager.closeAll();
    super.dispose();
}
```

### Rearrange

All the overlay entries in the OverlayManager will be arranged z-index by elevation value.
Create a new entry with it's elevation:

```dart
final myEntry = manager.show(
    elevation: 1
    // ...
);
```

Or rearrange it (after create):

```dart
myEntry.rearrange(newElevation);

// or

myEntry.elevation = 1;
manager.rearrange();

```


# Features and bugs

Please file feature requests and bugs at the [issue tracker](https://github.com/sonnts996/overlay_manager/issues).