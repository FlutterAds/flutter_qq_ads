import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_qq_ads/flutter_qq_ads.dart';
import 'package:flutter_qq_ads_example/home_page.dart';
import 'ads_config.dart';
import 'feed_page.dart';

void main() {
  /// 绑定引擎
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage());
  }
}
