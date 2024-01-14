import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:fluttervine/theme_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: App(),
    );
  }
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  
  // Variables & Functions go here

  List<Widget> pages() => <Widget>[

    // pages go here

  ];

  @override
  void initState() {
    super.initState();

    // inits go here

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "fluttervine",


      home: Scaffold(
        backgroundColor: themeColors["Background"],

        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,

          title: Text("FlutterVine", style: TextStyle(color: themeColors["Text"])),
        ),

        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Streaming Service", style: TextStyle(color: themeColors["Text"]))
          ],
        ),

      ),
    );
  }
}