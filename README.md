# Overlay Manager


## Import

```dart
import 'package:overlay_manager/overlay_manager.dart';
```

## Create

```dart
final manager = GlobalOverlayManager(navigatorKey: navKey);
```

or

```dart
final manager = ContextOverlayManager(context: context);
```

## Using

- For show an overlay:

```dart
manager.show(
  barrierColor: Colors.red.shade500.withOpacity(0.2),
  onDismiss: print,
  isDismissible: false,
  builder: (context, entry) => AlertMessage(
    onClose: () => entry.close(0),
  ),
);
```

call ``` entry.close(0) ``` to close this overlay.

- If you want to close all overlay when the screen is disposed, let's try:

```dart
@override
void dispose() {
    manager.closeAll();
    super.dispose();
}
```

- The [overlay] rearrange is coming soon.