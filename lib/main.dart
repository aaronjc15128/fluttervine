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
        extendBodyBehindAppBar: true,
        extendBody: true,
        backgroundColor: themeColors["Background"],

        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: AppBar(
            elevation: 0,
            actions: const [], // TODO: Add donate & github buttons
            backgroundColor: Colors.transparent,

            title: Text("FlutterVine", style: TextStyle(
              fontFamily: "Poppins",
              fontWeight: FontWeight.w300,
              fontStyle: FontStyle.italic,
              fontSize: 32,
              color: themeColors["Text"],
            )),
          ),
        ),

        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [themeColors["Secondary"], themeColors["Background-Transparent"]],
              begin: Alignment.topCenter,
              end: Alignment.center,
            )
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 17),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 50),
                Text("by Aaron Chauhan", style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.italic,
                  fontSize: 16,
                  color: themeColors["Text"],
                )),
                const SizedBox(height: 50),
        
                Text("Streaming Service", style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.italic,
                  fontSize: 16,
                  color: themeColors["Text"]
                )),
                const SizedBox(height: 10),
                Column(
        
                  children: [
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            fixedSize: const Size(130, 40),
                            backgroundColor: themeColors["Box"],
                          ),
                          child: Text("BBC iPlayer", style: TextStyle(
                            fontFamily: "Inter",
                            fontSize: 16,
                            color: themeColors["Text"]
                          )),
                        ), const SizedBox(width: 5),
                        ElevatedButton(
                          onPressed: () {
                            
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            fixedSize: const Size(130, 40),
                            backgroundColor: themeColors["Box"],
                          ),
                          child: Text("ITVX", style: TextStyle(
                            fontFamily: "Inter",
                            fontSize: 16,
                            color: themeColors["Text"]
                          )),
                        ), const SizedBox(width: 5),
                        ElevatedButton(
                          onPressed: () {
                            
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            fixedSize: const Size(130, 40),
                            backgroundColor: themeColors["Box"],
                          ),
                          child: Text("All4", style: TextStyle(
                            fontFamily: "Inter",
                            fontSize: 16,
                            color: themeColors["Text"]
                          )),
                        ), const SizedBox(width: 5),
                        ElevatedButton(
                          onPressed: () {
                            
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            fixedSize: const Size(130, 40),
                            backgroundColor: themeColors["Box"],
                          ),
                          child: Text("My5", style: TextStyle(
                            fontFamily: "Inter",
                            fontSize: 16,
                            color: themeColors["Text"]
                          )),
                        ), const SizedBox(width: 5),
                      ],
                    ), const SizedBox(height: 5),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            fixedSize: const Size(130, 40),
                            backgroundColor: themeColors["Box"],
                          ),
                          child: Text("STV Player", style: TextStyle(
                            fontFamily: "Inter",
                            fontSize: 16,
                            color: themeColors["Text"]
                          )),
                        ), const SizedBox(width: 5),
                        ElevatedButton(
                          onPressed: () {
                            
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            fixedSize: const Size(130, 40),
                            backgroundColor: themeColors["Box"],
                          ),
                          child: Text("UKTVPlay", style: TextStyle(
                            fontFamily: "Inter",
                            fontSize: 16,
                            color: themeColors["Text"]
                          )),
                        ), const SizedBox(width: 5),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 50),
        
                Text("Profile", style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.italic,
                  fontSize: 16,
                  color: themeColors["Text"]
                )),
                const SizedBox(height: 50),
        
                Text("Download", style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.italic,
                  fontSize: 16,
                  color: themeColors["Text"]
                )),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),

      ),
    );
  }
}