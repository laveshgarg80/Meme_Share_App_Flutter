import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:share_plus/share_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  var image = null;

  @override
  void initState() {
    generateRandomMeme();
  }

  void generateRandomMeme() async {
    //api call
    var url = Uri.parse('https://meme-api.herokuapp.com/gimme');
    var response = await http.get(url);
    var parsed = json.decode(response.body);
    setState(() {
      image = parsed["url"];
    });
  }

  void share() {
    //share
    Share.share('check this cool meme on reddit.. ${image}');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: Column(
            children: [
              //image
              (image != null)
                  ? Container(
                      width: 500, height: 500, child: Image.network(image))
                  : Container(),
              //for two Buttons
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //this button is basically to generate random memes
                    Container(
                      width: 195,
                      height: 50,
                      child: ElevatedButton(
                        child: Text("Get Random Meme"),
                        onPressed: () {
                          generateRandomMeme();
                        },
                      ),
                    ),
                    //this button is basically to share data in another apps
                    Container(
                      width: 195,
                      height: 50,
                      child: ElevatedButton(
                        child: Text("Share it"),
                        onPressed: () {
                          share();
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
