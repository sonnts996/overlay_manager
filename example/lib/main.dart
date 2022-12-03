import 'package:example/home_page.dart';
import 'package:flutter/material.dart';
import 'package:overlay_manager/overlay_manager.dart';

final navKey = GlobalKey<NavigatorState>();
final manager = GlobalOverlayManager(navigatorKey: navKey);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorKey: navKey,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}
