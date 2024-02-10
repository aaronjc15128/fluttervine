import 'package:flutter/material.dart';
import 'dart:io';

import 'package:file_picker/file_picker.dart';

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
  String version = "v1.0.0-beta.2";
  
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
  List<String> commands = ["...", "...", "..."];
  String scriptPath = "...";
  //late String downloadsPath;
  List<List<String>> parameters = [[], [], []];

  IconData scriptIcon = Icons.not_interested_rounded;
  List<bool> toggle = [false, false, false, false];
  List<double> toggleOpacity = [0.2, 0.2, 0.2, 0.2];

  void openScript() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ["py"],
      );

      if (result != null) {
        scriptPath = result.files.first.path!;
        setState(() {
          scriptIcon = Icons.done_rounded;
        });
      }
    }
    catch (e) {
      scriptPath = e.toString();    
    }
  }
  /*
  void openDownloads() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx'],
      );

      if (result != null) {
        downloadsPath = result.files.first.path!;
      }
    } catch (e) {
      
    }
  }
  */
  void getCommand() {
    setState(() {
      if (service != "...") {
        commands[0] = 'freevine.py profile --username "$username" --password "$password" --service "$service"';
        parameters[0] = ["--username '$username'", "--password '$password'", "--service '$service'"];
      }
    });

    setState(() {
      commands[1] = 'freevine.py get --titles "$url"';
      parameters[1] = ["--titles '$url'"];
    });

    setState(() {
      if (toggle[0]) {
        commands[2] = 'freevine.py get --episode "$episode" "$url"';
        parameters[2] = ["--episode '$episode' '$url'"];
      }
      else {
        if (season.length == 1) {
          season = "0$season";
        }
        if (toggle[1]) {
          commands[2] = 'freevine.py get --episode S${season}E$episode "$url"';
          parameters[2] = ["--episode S${season}E$episode '$url'"];
        }
        else if (toggle[2]) {
          commands[2] = 'freevine.py get --episode S${season}E$episode-S${season2}E$episode2 "$url"';
          parameters[2] = ["--episode S${season}E$episode-S${season2}E$episode2 '$url'"];
        }
        else if (toggle[3]) {
          commands[2] = 'freevine.py get --season S$season "$url"';
          parameters[2] = ["--season S$season '$url'"];
        }
      }
    });
  }

  void runTitles() async {
    String commandStart = "$scriptPath get";

    try {
      ProcessResult resultA = await Process.run(commandStart, parameters[1]); // ? titles
      setState(() {
        titles = resultA.stdout;
      });
    }
    catch (e) {
      setState(() {
        titles = "Oops! An exception occurred:\n$e";
      });
    }
  }

  void runDownload() async {
    String commandStart = "$scriptPath get";

    try {
      ProcessResult resultA = await Process.run(commandStart, parameters[0]); // ? profile
      setState(() {
        download = resultA.stdout;
      });
      ProcessResult resultB = await Process.run(commandStart, parameters[2]); // ? download
      setState(() {
        download = resultB.stdout;
      });
    }
    catch (e) {
      setState(() {
        download = "Oh no! An exception occurred:\n$e";
      });
    }
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
      theme: ThemeData(
        inputDecorationTheme: InputDecorationTheme(
          focusColor: gradientTop,
          fillColor: gradientTop,
          iconColor: gradientTop,
          prefixIconColor: gradientTop,
          suffixIconColor: gradientTop,
        ),
      ),

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

            title: Column(
              children: [
                Text("FlutterVine", style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w300,
                  fontStyle: FontStyle.italic,
                  fontSize: 32,
                  color: themeColors["Text"],
                )),
              ],
            ),
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
                  Text(version, style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.italic,
                    fontSize: 14,
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
                          cursorColor: gradientTop,
                          style: TextStyle(fontFamily: "Inter", fontWeight: FontWeight.w400, color: themeColors["Text"]),
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: "Username",
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            fillColor: themeColors["Box"],
                            filled: true,
                            floatingLabelStyle: TextStyle(fontFamily: "Inter", fontWeight: FontWeight.w400, color: gradientTop),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: gradientTop),
                            ),
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
                          cursorColor: gradientTop,
                          style: TextStyle(fontFamily: "Inter", fontWeight: FontWeight.w400, color: themeColors["Text"]),
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: "Password",
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            fillColor: themeColors["Box"],
                            filled: true,
                            floatingLabelStyle: TextStyle(fontFamily: "Inter", fontWeight: FontWeight.w400, color: gradientTop),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: gradientTop),
                            ),
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
                      cursorColor: gradientTop,
                      style: TextStyle(fontFamily: "Inter", fontWeight: FontWeight.w400, color: themeColors["Text"]),
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: "URL",
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        fillColor: themeColors["Box"],
                        filled: true,
                        floatingLabelStyle: TextStyle(fontFamily: "Inter", fontWeight: FontWeight.w400, color: gradientTop),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: gradientTop),
                        ),
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
                            cursorColor: gradientTop,
                            style: TextStyle(fontFamily: "Inter", fontWeight: FontWeight.w400, color: themeColors["Text"]),
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: "Name",
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              fillColor: themeColors["Box"],
                              filled: true,
                              floatingLabelStyle: TextStyle(fontFamily: "Inter", fontWeight: FontWeight.w400, color: gradientTop),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: gradientTop),
                              ),
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
                          width: 60,
                          height: 50,
                          child: TextField(
                            cursorColor: gradientTop,
                            style: TextStyle(fontFamily: "Inter", fontWeight: FontWeight.w400, color: themeColors["Text"]),
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: "S #",
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              fillColor: themeColors["Box"],
                              filled: true,
                              floatingLabelStyle: TextStyle(fontFamily: "Inter", fontWeight: FontWeight.w400, color: gradientTop),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: gradientTop),
                              ),
                            ),
                            onChanged: (value) {
                              season = value;
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: 60,
                          height: 50,
                          child: TextField(
                            cursorColor: gradientTop,
                            style: TextStyle(fontFamily: "Inter", fontWeight: FontWeight.w400, color: themeColors["Text"]),
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: "E #",
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              fillColor: themeColors["Box"],
                              filled: true,
                              floatingLabelStyle: TextStyle(fontFamily: "Inter", fontWeight: FontWeight.w400, color: gradientTop),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: gradientTop),
                              ),
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
                          width: 60,
                          height: 50,
                          child: TextField(
                            cursorColor: gradientTop,
                            style: TextStyle(fontFamily: "Inter", fontWeight: FontWeight.w400, color: themeColors["Text"]),
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: "S #",
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              fillColor: themeColors["Box"],
                              filled: true,
                              floatingLabelStyle: TextStyle(fontFamily: "Inter", fontWeight: FontWeight.w400, color: gradientTop),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: gradientTop),
                              ),
                            ),
                            onChanged: (value) {
                              season = value;
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: 60,
                          height: 50,
                          child: TextField(
                            cursorColor: gradientTop,
                            style: TextStyle(fontFamily: "Inter", fontWeight: FontWeight.w400, color: themeColors["Text"]),
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: "E #",
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              fillColor: themeColors["Box"],
                              filled: true,
                              floatingLabelStyle: TextStyle(fontFamily: "Inter", fontWeight: FontWeight.w400, color: gradientTop),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: gradientTop),
                              ),
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
                          width: 60,
                          height: 50,
                          child: TextField(
                            cursorColor: gradientTop,
                            style: TextStyle(fontFamily: "Inter", fontWeight: FontWeight.w400, color: themeColors["Text"]),
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: "S #",
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              fillColor: themeColors["Box"],
                              filled: true,
                              floatingLabelStyle: TextStyle(fontFamily: "Inter", fontWeight: FontWeight.w400, color: gradientTop),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: gradientTop),
                              ),
                            ),
                            onChanged: (value) {
                              season2 = value;
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: 60,
                          height: 50,
                          child: TextField(
                            cursorColor: gradientTop,
                            style: TextStyle(fontFamily: "Inter", fontWeight: FontWeight.w400, color: themeColors["Text"]),
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: "E #",
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              fillColor: themeColors["Box"],
                              filled: true,
                              floatingLabelStyle: TextStyle(fontFamily: "Inter", fontWeight: FontWeight.w400, color: gradientTop),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: gradientTop),
                              ),
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
                          width: 60,
                          height: 50,
                          child: TextField(
                            cursorColor: gradientTop,
                            style: TextStyle(fontFamily: "Inter", fontWeight: FontWeight.w400, color: themeColors["Text"]),
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: "S #",
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              fillColor: themeColors["Box"],
                              filled: true,
                              floatingLabelStyle: TextStyle(fontFamily: "Inter", fontWeight: FontWeight.w400, color: gradientTop),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: gradientTop),
                              ),
                              
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

                  // ~ Options
                  Text("Options", textAlign: TextAlign.left, style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.italic,
                    fontSize: 16,
                    color: themeColors["Text"],
                  )),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Column(
                        children: [
                          // * resolution options here
                        ],
                      ),
                      Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              openScript();
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              fixedSize: const Size(250, 40),
                              backgroundColor: themeColors["Box"],
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("freevine.py location", style: TextStyle(
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: themeColors["Text"],
                                )),
                                const SizedBox(width: 20),
                                Icon(scriptIcon, color: themeColors["Text"]),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ],
                  ),
                  Text(scriptPath, style: TextStyle(
                    fontFamily: "Inter",
                    fontSize: 14,
                    color: themeColors["Text"],
                  )),
                  const SizedBox(height: 50),
                  
                  // ~ Buttons
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
                        child: Text("Commands", style: TextStyle(
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: themeColors["Text"],
                        )),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          runTitles();
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
                          runDownload();
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
            
                  // ~ Commands
                  Text("Commands", style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.italic,
                    fontSize: 16,
                    color: themeColors["Text"],
                  )),
                  Text(commands[0], style: TextStyle(
                    fontFamily: "Inter",
                    fontSize: 16,
                    color: themeColors["Text"],
                  )),
                  Text(commands[1], style: TextStyle(
                    fontFamily: "Inter",
                    fontSize: 16,
                    color: themeColors["Text"],
                  )),
                  Text(commands[2], style: TextStyle(
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