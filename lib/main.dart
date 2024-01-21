import 'package:flutter/material.dart';
// TODO: add dart:io

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
  
  Color gradientTop = themeColors["Background-Light"];
  String service = "...";
  late String username;
  late String password;
  late String url;
  late String season;
  late String episode;
  late String season2;
  late String episode2;
  String download = "...";
  String titles = "...";
  String command = "...";

  List<bool> toggle = [false, false, false, false];
  List<double> toggleOpacity = [0.2, 0.2, 0.2, 0.2];

  void getCommand() {
    setState(() {
      command = 'freevine.py profile --username "$username" --password "$password" --service "$service"';
      command = '$command && freevine.py get --titles "$url"';

      if (toggle[0]) {
        command = '$command && freevine.py get --episode "$episode" "$url"';
      }
      else {
        if (season.length == 1) {
          season = "0$season";
        }

        if (toggle[1]) {
          command = '$command && freevine.py get --episode S${season}E$episode "$url"';
        }
        else if (toggle[2]) {
          command = '$command && freevine.py get --episode S${season}E$episode-S${season2}E$episode2 "$url"';
        }
        else if (toggle[3]) {
          command = '$command && freevine.py get --season S$season "$url"';
        }
      }
    });
  
  }

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
            actions: const [],
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
              colors: [gradientTop, themeColors["Background-Transparent"]],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 17, right: 17),
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
                    
                  // ~ Streaming Service
                  Row(
                    children: [
                      Text("Streaming Service", style: TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.italic,
                        fontSize: 16,
                        color: themeColors["Text"],
                      )),
                      Text(" ~ $service", style: TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w300,
                        fontStyle: FontStyle.italic,
                        fontSize: 16,
                        color: themeColors["Text"],
                      )),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Column(
                    children: [
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                gradientTop = themeColors["iPlayer"];
                                service = "BBC iPlayer";
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              fixedSize: const Size(140, 40),
                              backgroundColor: themeColors["Box"],
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            child: Text("BBC iPlayer", style: TextStyle(
                              fontFamily: "Inter",
                              fontSize: 16,
                              color: themeColors["Text"],
                            )),
                          ), const SizedBox(width: 5),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                gradientTop = themeColors["ITVX"];
                                service = "ITVX";
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              fixedSize: const Size(140, 40),
                              backgroundColor: themeColors["Box"],
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            child: Text("ITVX", style: TextStyle(
                              fontFamily: "Inter",
                              fontSize: 16,
                              color: themeColors["Text"],
                            )),
                          ), const SizedBox(width: 5),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                gradientTop = themeColors["All4"];
                                service = "All4";
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              fixedSize: const Size(140, 40),
                              backgroundColor: themeColors["Box"],
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            child: Text("All4", style: TextStyle(
                              fontFamily: "Inter",
                              fontSize: 16,
                              color: themeColors["Text"],
                            )),
                          ), const SizedBox(width: 5),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                gradientTop = themeColors["My5"];
                                service = "My5";
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              fixedSize: const Size(140, 40),
                              backgroundColor: themeColors["Box"],
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            child: Text("My5", style: TextStyle(
                              fontFamily: "Inter",
                              fontSize: 16,
                              color: themeColors["Text"],
                            )),
                          ), const SizedBox(width: 5),
                        ],
                      ), const SizedBox(height: 5),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                gradientTop = themeColors["STV"];
                                service = "STV Player";
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              fixedSize: const Size(140, 40),
                              backgroundColor: themeColors["Box"],
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            child: Text("STV Player", style: TextStyle(
                              fontFamily: "Inter",
                              fontSize: 16,
                              color: themeColors["Text"],
                            )),
                          ), const SizedBox(width: 5),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                gradientTop = themeColors["UKTVPlay"];
                                service = "UKTVPlay";
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              fixedSize: const Size(140, 40),
                              backgroundColor: themeColors["Box"],
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            child: Text("UKTVPlay", style: TextStyle(
                              fontFamily: "Inter",
                              fontSize: 16,
                              color: themeColors["Text"],
                            )),
                          ), const SizedBox(width: 5),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                    
                  // ~ Profile
                  Text("Profile", textAlign: TextAlign.left, style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.italic,
                    fontSize: 16,
                    color: themeColors["Text"],
                  )),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      SizedBox(
                        width: 245,
                        height: 50,
                        child: TextField(
                          style: TextStyle(fontFamily: "Inter", fontWeight: FontWeight.w400, color: themeColors["Text"]),
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: "Username",
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            fillColor: themeColors["Box"],
                            filled: true,
                          ),
                          onChanged: (value) {
                            username = value;
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: 245,
                        height: 50,
                        child: TextField(
                          style: TextStyle(fontFamily: "Inter", fontWeight: FontWeight.w400, color: themeColors["Text"]),
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: "Password",
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            fillColor: themeColors["Box"],
                            filled: true,
                          ),
                          onChanged: (value) {
                            password = value;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                    
            
                  // ~ Download
                  Text("Download", style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.italic,
                    fontSize: 16,
                    color: themeColors["Text"],
                  )),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 500,
                    height: 50,
                    child: TextField(
                      style: TextStyle(fontFamily: "Inter", fontWeight: FontWeight.w400, color: themeColors["Text"]),
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: "URL",
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        fillColor: themeColors["Box"],
                        filled: true,
                      ),
                      onChanged: (value) {
                        url = value;
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Opacity(
                    opacity: toggleOpacity[0],
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (toggle[0]) {
                                toggle[0] = false;
                                toggleOpacity[0] = 0.2;
                              }
                              else {
                                toggle[0] = true;
                                toggleOpacity[0] = 1;
                              }
                              toggle[1] = toggle[2] = toggle[3] = false;
                              toggleOpacity[1] = toggleOpacity[2] = toggleOpacity[3] = 0.2;
                            });
                          },
                          icon: Icon(toggle[0] ? Icons.check_circle_rounded : Icons.circle_outlined, size: 20, color: themeColors["Text"]),
                        ),
                        const SizedBox(width: 5),
                        SizedBox(
                          width: 150,
                          child: Text("Episode", style: TextStyle(
                            fontFamily: "Inter",
                            fontSize: 16,
                            color: themeColors["Text"],
                          )),
                        ),
                        SizedBox(
                          width: 305,
                          height: 50,
                          child: TextField(
                            style: TextStyle(fontFamily: "Inter", fontWeight: FontWeight.w400, color: themeColors["Text"]),
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: "Name",
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              fillColor: themeColors["Box"],
                              filled: true,
                            ),
                            onChanged: (value) {
                              episode = value;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Opacity(
                    opacity: toggleOpacity[1],
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (toggle[1]) {
                                toggle[1] = false;
                                toggleOpacity[1] = 0.2;
                              }
                              else {
                                toggle[1] = true;
                                toggleOpacity[1] = 1;
                              }
                              toggle[0] = toggle[2] = toggle[3] = false;
                              toggleOpacity[0] = toggleOpacity[2] = toggleOpacity[3] = 0.2;
                            });
                          },
                          icon: Icon(toggle[1] ? Icons.check_circle_rounded : Icons.circle_outlined, size: 20, color: themeColors["Text"]),
                        ),
                        const SizedBox(width: 5),
                        SizedBox(
                          width: 150,
                          child: Text("Episode", style: TextStyle(
                            fontFamily: "Inter",
                            fontSize: 16,
                            color: themeColors["Text"],
                          )),
                        ),
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: TextField(
                            style: TextStyle(fontFamily: "Inter", fontWeight: FontWeight.w400, color: themeColors["Text"]),
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: "S #",
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              fillColor: themeColors["Box"],
                              filled: true,
                            ),
                            onChanged: (value) {
                              season = value;
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: TextField(
                            style: TextStyle(fontFamily: "Inter", fontWeight: FontWeight.w400, color: themeColors["Text"]),
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: "E #",
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              fillColor: themeColors["Box"],
                              filled: true,
                            ),
                            onChanged: (value) {
                              episode = value;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Opacity(
                    opacity: toggleOpacity[2],
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (toggle[2]) {
                                toggle[2] = false;
                                toggleOpacity[2] = 0.2;
                              }
                              else {
                                toggle[2] = true;
                                toggleOpacity[2] = 1;
                              }
                              toggle[0] = toggle[1] = toggle[3] = false;
                              toggleOpacity[0] = toggleOpacity[1] = toggleOpacity[3] = 0.2;
                            });
                          },
                          icon: Icon(toggle[2] ? Icons.check_circle_rounded : Icons.circle_outlined, size: 20, color: themeColors["Text"]),
                        ),
                        const SizedBox(width: 5),
                        SizedBox(
                          width: 150,
                          child: Text("Episode Range", style: TextStyle(
                            fontFamily: "Inter",
                            fontSize: 16,
                            color: themeColors["Text"],
                          )),
                        ),
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: TextField(
                            style: TextStyle(fontFamily: "Inter", fontWeight: FontWeight.w400, color: themeColors["Text"]),
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: "S #",
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              fillColor: themeColors["Box"],
                              filled: true,
                            ),
                            onChanged: (value) {
                              season = value;
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: TextField(
                            style: TextStyle(fontFamily: "Inter", fontWeight: FontWeight.w400, color: themeColors["Text"]),
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: "E #",
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              fillColor: themeColors["Box"],
                              filled: true,
                            ),
                            onChanged: (value) {
                              episode = value;
                            },
                          ),
                        ),
                        SizedBox(
                          width: 30,
                          child: Text("-", textAlign: TextAlign.center, style: TextStyle(
                            fontFamily: "Inter",
                            fontSize: 16,
                            color: themeColors["Text"],
                          )),
                        ),
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: TextField(
                            style: TextStyle(fontFamily: "Inter", fontWeight: FontWeight.w400, color: themeColors["Text"]),
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: "S #",
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              fillColor: themeColors["Box"],
                              filled: true,
                            ),
                            onChanged: (value) {
                              season2 = value;
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: TextField(
                            style: TextStyle(fontFamily: "Inter", fontWeight: FontWeight.w400, color: themeColors["Text"]),
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: "E #",
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              fillColor: themeColors["Box"],
                              filled: true,
                            ),
                            onChanged: (value) {
                              episode2 = value;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Opacity(
                    opacity: toggleOpacity[3],
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (toggle[3]) {
                                toggle[3] = false;
                                toggleOpacity[3] = 0.2;
                              }
                              else {
                                toggle[3] = true;
                                toggleOpacity[3] = 1;
                              }
                              toggle[0] = toggle[1] = toggle[2] = false;
                              toggleOpacity[0] = toggleOpacity[1] = toggleOpacity[2] = 0.2;
                            });
                          },
                          icon: Icon(toggle[3] ? Icons.check_circle_rounded : Icons.circle_outlined, size: 20, color: themeColors["Text"]),
                        ),
                        const SizedBox(width: 5),
                        SizedBox(
                          width: 150,
                          child: Text("Season", style: TextStyle(
                            fontFamily: "Inter",
                            fontSize: 16,
                            color: themeColors["Text"],
                          )),
                        ),
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: TextField(
                            style: TextStyle(fontFamily: "Inter", fontWeight: FontWeight.w400, color: themeColors["Text"]),
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: "S #",
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              fillColor: themeColors["Box"],
                              filled: true,
                            ),
                            onChanged: (value) {
                              season = value;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          getCommand();
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          fixedSize: const Size(140, 40),
                          backgroundColor: themeColors["Box"],
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: Text("Command", style: TextStyle(
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: themeColors["Text"],
                        )),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          fixedSize: const Size(140, 40),
                          backgroundColor: themeColors["Box"],
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: Text("Titles", style: TextStyle(
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: themeColors["Text"],
                        )),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          fixedSize: const Size(140, 40),
                          backgroundColor: themeColors["Box"],
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: Text("Download", style: TextStyle(
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: themeColors["Text"],
                        )),
                      ),
                    ],
                  ),
            
            
                  const SizedBox(height: 30),
            
                  // ~ Command
                  Text("Command", style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.italic,
                    fontSize: 16,
                    color: themeColors["Text"],
                  )),
                  Text(command, style: TextStyle(
                    fontFamily: "Inter",
                    fontSize: 16,
                    color: themeColors["Text"],
                  )),
                  const SizedBox(height: 30),
            
                  // ~ Titles
                  Text("Titles", style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.italic,
                    fontSize: 16,
                    color: themeColors["Text"],
                  )),
                  Text(titles, style: TextStyle(
                    fontFamily: "Inter",
                    fontSize: 16,
                    color: themeColors["Text"],
                  )),
                  const SizedBox(height: 30),
            
                  // ~ Download
                  Text("Downloading...", style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.italic,
                    fontSize: 16,
                    color: themeColors["Text"],
                  )),
                  Text(download, style: TextStyle(
                    fontFamily: "Inter",
                    fontSize: 16,
                    color: themeColors["Text"],
                  )),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}