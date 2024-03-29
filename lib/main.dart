import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:url_launcher/url_launcher.dart';

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
  String version = "v1.0.0-beta.4";
  
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
  List<String> commands = ["...", "...", "...", "..."];
  String scriptPath = "...";

  IconData scriptIcon = Icons.not_interested_rounded;
  bool cache = false;
  IconData cacheIcon = Icons.not_interested_rounded;
  List<bool> toggle = [false, false, false, false, false];
  List<double> toggleOpacity = [0.2, 0.2, 0.2, 0.2, 0.2];

  _launchURL(String urlin) async {
    final Uri url = Uri.parse(urlin);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

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

  void clearCache() {
    setState(() {
      cache = cache ? false : true;
      cacheIcon = cache ? Icons.done_rounded : Icons.not_interested_rounded;
    });
  }

  void getCommand() {
    setState(() {
      if (cache) {
        commands[3] = 'freevine.py clear-cache';
      }
      else {
        commands[3] = '@echo';
      }
    });

    setState(() {
      if (service != "...") {
        commands[0] = 'freevine.py profile --username "$username" --password "$password" --service "$service"';
      }
    });

    setState(() {
      commands[1] = 'freevine.py get --titles "$url"';
    });

    setState(() {
      if (toggle[0]) {
        commands[2] = 'freevine.py get --episode "$episode" "$url"';
      }
      else if (toggle[4]) {
        commands[2] = 'freevine.py get --movie "$url"';
      }
      else {
        if (season.length == 1) {
          season = "0$season";
        }
        else if (episode.length == 1) {
          episode = "0$episode";
        }

        if (toggle[1]) {
          commands[2] = 'freevine.py get --episode S${season}E$episode "$url"';
        }
        else if (toggle[2]) {
          commands[2] = 'freevine.py get --episode S${season}E$episode-S${season2}E$episode2 "$url"';
        }
        else if (toggle[3]) {
          commands[2] = 'freevine.py get --season S$season "$url"';
        }
      }
    });
  }

  void runTitles() async {
    try {
      ProcessResult resultA = await Process.run(commands[1], []); // ? titles
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
    try {
      ProcessResult resultA = await Process.run(commands[3], []); // ? cache
      setState(() {
        download = resultA.stdout;
      });
      ProcessResult resultB = await Process.run(commands[0], []); // ? profile
      setState(() {
        download = resultB.stdout;
      });
      ProcessResult resultC = await Process.run(commands[2], []); // ? download
      setState(() {
        download = resultC.stdout;
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
            backgroundColor: Colors.transparent,

            title: Row(
              children: [
                Text("FlutterVine", style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w300,
                  fontStyle: FontStyle.italic,
                  fontSize: 32,
                  color: themeColors["Text"],
                )),
                const SizedBox(width: 370),
                IconButton(
                  onPressed: () {
                    _launchURL("https://github.com/aaronjc15128/fluttervine");
                  },
                  icon: Icon(Icons.code_rounded, color: themeColors["Text"]),
                ),
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
                                service = "BBC";
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              fixedSize: const Size(140, 40),
                              backgroundColor: themeColors["Box"],
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              foregroundColor: themeColors["iPlayer"],
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
                              foregroundColor: themeColors["ITVX"],
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
                                service = "ALL4";
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              fixedSize: const Size(140, 40),
                              backgroundColor: themeColors["Box"],
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              foregroundColor: themeColors["All4"],
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
                                service = "MY5";
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              fixedSize: const Size(140, 40),
                              backgroundColor: themeColors["Box"],
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              foregroundColor: themeColors["My5"],
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
                                service = "STV";
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              fixedSize: const Size(140, 40),
                              backgroundColor: themeColors["Box"],
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              foregroundColor: themeColors["STV"],
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
                                service = "UKTVPLAY";
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              fixedSize: const Size(140, 40),
                              backgroundColor: themeColors["Box"],
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              foregroundColor: themeColors["UKTVPlay"],
                            ),
                            child: Text("UKTVPlay", style: TextStyle(
                              fontFamily: "Inter",
                              fontSize: 16,
                              color: themeColors["Text"],
                            )),
                          ), const SizedBox(width: 5),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                gradientTop = themeColors["Roku"];
                                service = "ROKU";
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              fixedSize: const Size(140, 40),
                              backgroundColor: themeColors["Box"],
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              foregroundColor: themeColors["Roku"],
                            ),
                            child: Text("Roku", style: TextStyle(
                              fontFamily: "Inter",
                              fontSize: 16,
                              color: themeColors["Text"],
                            )),
                          ), const SizedBox(width: 5),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                gradientTop = themeColors["Crackle"];
                                service = "CRACKLE";
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              fixedSize: const Size(140, 40),
                              backgroundColor: themeColors["Box"],
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              foregroundColor: themeColors["Crackle"],
                            ),
                            child: Text("Crackle", style: TextStyle(
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
                                gradientTop = themeColors["CWTV"];
                                service = "CW";
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              fixedSize: const Size(140, 40),
                              backgroundColor: themeColors["Box"],
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              foregroundColor: themeColors["CWTV"],
                            ),
                            child: Text("CWTV", style: TextStyle(
                              fontFamily: "Inter",
                              fontSize: 16,
                              color: themeColors["Text"],
                            )),
                          ), const SizedBox(width: 5),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                gradientTop = themeColors["TubiTV"];
                                service = "TUBITV";
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              fixedSize: const Size(140, 40),
                              backgroundColor: themeColors["Box"],
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              foregroundColor: themeColors["TubiTV"],
                            ),
                            child: Text("Tubi TV", style: TextStyle(
                              fontFamily: "Inter",
                              fontSize: 16,
                              color: themeColors["Text"],
                            )),
                          ), const SizedBox(width: 5),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                gradientTop = themeColors["PlutoTV"];
                                service = "PLUTO";
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              fixedSize: const Size(140, 40),
                              backgroundColor: themeColors["Box"],
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              foregroundColor: themeColors["PlutoTV"],
                            ),
                            child: Text("Pluto TV", style: TextStyle(
                              fontFamily: "Inter",
                              fontSize: 16,
                              color: themeColors["Text"],
                            )),
                          ), const SizedBox(width: 5),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                gradientTop = themeColors["CBCgem"];
                                service = "CBC";
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              fixedSize: const Size(140, 40),
                              backgroundColor: themeColors["Box"],
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              foregroundColor: themeColors["CBCgem"],
                            ),
                            child: Text("CBC Gem", style: TextStyle(
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
                                gradientTop = themeColors["CTV"];
                                service = "CTV";
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              fixedSize: const Size(140, 40),
                              backgroundColor: themeColors["Box"],
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              foregroundColor: themeColors["CTV"],
                            ),
                            child: Text("CTV", style: TextStyle(
                              fontFamily: "Inter",
                              fontSize: 16,
                              color: themeColors["Text"],
                            )),
                          ), const SizedBox(width: 5),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                gradientTop = themeColors["ABC"];
                                service = "ABC";
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              fixedSize: const Size(140, 40),
                              backgroundColor: themeColors["Box"],
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              foregroundColor: themeColors["ABC"],
                            ),
                            child: Text("ABC iView", style: TextStyle(
                              fontFamily: "Inter",
                              fontSize: 16,
                              color: themeColors["Text"],
                            )),
                          ), const SizedBox(width: 5),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                gradientTop = themeColors["TVNZ"];
                                service = "TVNZ";
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              fixedSize: const Size(140, 40),
                              backgroundColor: themeColors["Box"],
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              foregroundColor: themeColors["TVNZ"],
                            ),
                            child: Text("TVNZ", style: TextStyle(
                              fontFamily: "Inter",
                              fontSize: 16,
                              color: themeColors["Text"],
                            )),
                          ), const SizedBox(width: 5),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                gradientTop = themeColors["SVTPlay"];
                                service = "SVTPlay";
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              fixedSize: const Size(140, 40),
                              backgroundColor: themeColors["Box"],
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              foregroundColor: themeColors["STVPlay"],
                            ),
                            child: Text("SVTPlay", style: TextStyle(
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
                                gradientTop = themeColors["TV4Play"];
                                service = "TV4Play";
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              fixedSize: const Size(140, 40),
                              backgroundColor: themeColors["Box"],
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              foregroundColor: themeColors["TV4Play"],
                            ),
                            child: Text("TV4Play", style: TextStyle(
                              fontFamily: "Inter",
                              fontSize: 16,
                              color: themeColors["Text"],
                            )),
                          ), const SizedBox(width: 5),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                gradientTop = themeColors["PlexTV"];
                                service = "Plex";
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              fixedSize: const Size(140, 40),
                              backgroundColor: themeColors["Box"],
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              foregroundColor: themeColors["PlexTV"],
                            ),
                            child: Text("Plex.tv", style: TextStyle(
                              fontFamily: "Inter",
                              fontSize: 16,
                              color: themeColors["Text"],
                            )),
                          ), const SizedBox(width: 5),
                        ],
                      ), const SizedBox(height: 5),
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
                              toggle[1] = toggle[2] = toggle[3] = toggle[4] = false;
                              toggleOpacity[1] = toggleOpacity[2] = toggleOpacity[3] = toggleOpacity[4] = 0.2;
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
                              toggle[0] = toggle[2] = toggle[3] = toggle[4] = false;
                              toggleOpacity[0] = toggleOpacity[2] = toggleOpacity[3] = toggleOpacity[4] = 0.2;
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
                              toggle[0] = toggle[1] = toggle[3] = toggle[4] = false;
                              toggleOpacity[0] = toggleOpacity[1] = toggleOpacity[3] = toggleOpacity[4] = 0.2;
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
                              toggle[0] = toggle[1] = toggle[2] = toggle[4] = false;
                              toggleOpacity[0] = toggleOpacity[1] = toggleOpacity[2] = toggleOpacity[4] = 0.2;
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
                  const SizedBox(height: 10),
                  Opacity(
                    opacity: toggleOpacity[4],
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (toggle[4]) {
                                toggle[4] = false;
                                toggleOpacity[4] = 0.2;
                              }
                              else {
                                toggle[4] = true;
                                toggleOpacity[4] = 1;
                              }
                              toggle[0] = toggle[1] = toggle[2] = toggle[3] = false;
                              toggleOpacity[0] = toggleOpacity[1] = toggleOpacity[2] = toggleOpacity[3] = 0.2;
                            });
                          },
                          icon: Icon(toggle[4] ? Icons.check_circle_rounded : Icons.circle_outlined, size: 20, color: themeColors["Text"]),
                        ),
                        const SizedBox(width: 5),
                        SizedBox(
                          width: 150,
                          child: Text("Movie", style: TextStyle(
                            fontFamily: "Inter",
                            fontSize: 16,
                            color: themeColors["Text"],
                          )),
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
                      /*const Column(
                        children: [
                          // * resolution options here
                        ],
                      ), const SizedBox(width: 10),*/
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
                              foregroundColor: themeColors["Box"],
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
                      ), const SizedBox(width: 10),
                      Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              clearCache();
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              fixedSize: const Size(200, 40),
                              backgroundColor: themeColors["Box"],
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              foregroundColor: themeColors["Box"],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Clear Cache", style: TextStyle(
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: themeColors["Text"],
                                )),
                                const SizedBox(width: 20),
                                Icon(cacheIcon, color: themeColors["Text"]),
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
                          foregroundColor: themeColors["Box"],
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
                          foregroundColor: themeColors["Box"],
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
                          foregroundColor: themeColors["Box"],
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
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: commands[3]));
                        },
                        icon: Icon(Icons.copy_rounded, size: 15, color: themeColors["Text"]),
                      ),
                      const SizedBox(width: 5),
                      Text(commands[3], style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 16,
                        color: themeColors["Text"],
                      )),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: commands[0]));
                        },
                        icon: Icon(Icons.copy_rounded, size: 15, color: themeColors["Text"]),
                      ),
                      const SizedBox(width: 5),
                      Text(commands[0], style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 16,
                        color: themeColors["Text"],
                      )),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: commands[1]));
                        },
                        icon: Icon(Icons.copy_rounded, size: 15, color: themeColors["Text"]),
                      ),
                      const SizedBox(width: 5),
                      Text(commands[1], style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 16,
                        color: themeColors["Text"],
                      )),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: commands[2]));
                        },
                        icon: Icon(Icons.copy_rounded, size: 15, color: themeColors["Text"]),
                      ),
                      const SizedBox(width: 5),
                      Text(commands[2], style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 16,
                        color: themeColors["Text"],
                      )),
                    ],
                  ),
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