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

          title: Text("FlutterVine", style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w300,
            fontStyle: FontStyle.italic,
            fontSize: 32,
            color: themeColors["Text"],
          )),
        ),

        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text("Streaming Service", textAlign: TextAlign.center, style: TextStyle(
              fontFamily: "Poppins",
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.italic,
              fontSize: 16,
              color: themeColors["Text"]
            )),
            Text("Streaming Service", textAlign: TextAlign.center, style: TextStyle(
              fontFamily: "Poppins",
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.italic,
              fontSize: 16,
              color: themeColors["Text"]
            )),
          ],
        ),

      ),
    );
  }
}