import 'package:flutter/material.dart';
import 'package:fluttering_remote_config/fluttering_remote_config.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AwesomeRemoteConfig remoteConfig;

  @override
  void initState() {
    super.initState();
    remoteConfig = AwesomeRemoteConfig();
    remoteConfig.initial(AwesomeRemoteConfigSetting());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: const Center(
          child: Text(
            'This is a example for remote config flutter',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
