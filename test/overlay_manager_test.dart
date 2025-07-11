/*
 ⚠️ AI-Assisted Code: 
 - This section was generated with help from Copilot.
 - Date: 11/7/25
 - Reviewed by: sonnts996
*/

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:overlay_manager/src/manager/overlay_manager.dart';
import 'package:overlay_manager/src/models/overlay_manager_entry.dart';

void main() {
  group('OverlayManager integration tests', () {
    late ContextOverlayManager manager;
    late BuildContext testContext;

    setUp(() {});

    Future<void> pumpTestWidget(WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              testContext = context;
              return Scaffold(body: Container());
            },
          ),
        ),
      );
      manager = ContextOverlayManager(context: testContext);
    }

    testWidgets('show adds entry and topEntry is correct', (tester) async {
      await pumpTestWidget(tester);
      OverlayManagerEntry entry = manager.show(
        builder: (context, entry) => Container(),
      );
      expect(manager.count, 1);
      expect(manager.topEntry, entry);
      expect(entry.closed, false);
    });

    testWidgets('pop closes top entry', (tester) async {
      await pumpTestWidget(tester);
      OverlayManagerEntry entry = manager.show(
        builder: (context, entry) => Container(),
      );
      manager.pop();
      expect(entry.closed, true);
      expect(manager.count, 0);
    });

    testWidgets('closeAll closes all entries', (tester) async {
      await pumpTestWidget(tester);
      var entry1 = manager.show(builder: (context, entry) => Container());
      var entry2 = manager.show(builder: (context, entry) => Container());
      expect(manager.count, 2);
      manager.closeAll();
      expect(entry1.closed, true);
      expect(entry2.closed, true);
      expect(manager.count, 0);
    });

    testWidgets('rearrange sorts entries by elevation', (tester) async {
      await pumpTestWidget(tester);
      var entry1 = manager.show(
        builder: (context, entry) => Container(),
        elevation: 5,
      );
      var entry2 = manager.show(
        builder: (context, entry) => Container(),
        elevation: 1,
      );
      manager.rearrange();
      expect(manager.topEntry, entry1);
      entry1.rearrange(0);
      manager.rearrange();
      expect(manager.topEntry, entry2);
    });

    testWidgets('onDismiss is called when entry is closed', (tester) async {
      await pumpTestWidget(tester);
      bool dismissed = false;
      var entry = manager.show(
        builder: (context, entry) => Container(),
        onDismiss: (_) => dismissed = true,
      );
      entry.close();
      expect(dismissed, true);
    });

    testWidgets('show adds entry above or below based on elevation', (tester) async {
      await pumpTestWidget(tester);

      // Add the first entry with elevation 5
      final entry1 = manager.show(
        builder: (context, entry) => Container(),
        elevation: 5,
      );

      // Add a new entry with higher elevation (10)
      final entryHigh = manager.show(
        builder: (context, entry) => Container(),
        elevation: 10,
      );

      // The higher elevation entry should be above (after) the first entry
      expect(manager.count, 2);
      expect(manager.topEntry, entryHigh);
      expect(manager.topEntry!.elevation, greaterThan(entry1.elevation));

      // Remove all and add again for lower elevation
      manager.closeAll();

      final entry2 = manager.show(
        builder: (context, entry) => Container(),
        elevation: 5,
      );
      final entryLow = manager.show(
        builder: (context, entry) => Container(),
        elevation: 1,
      );

      // The lower elevation entry should be below (before) the first entry
      expect(manager.count, 2);
      expect(manager.topEntry, entry2);
      expect(entryLow.elevation, lessThan(entry2.elevation));
    });
  });
}
