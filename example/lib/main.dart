import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController textEditingControllerUrl = new TextEditingController();
  TextEditingController textEditingControllerId = new TextEditingController();

  @override
  initState() {
    super.initState();
  }

  void playYoutubeVideo() {
    FlutterYoutube.playYoutubeVideoByUrl(
      apiKey: "<API_KEY>",
      videoUrl: "https://www.youtube.com/watch?v=wgTBLj7rMPM",
    );
  }

  void playYoutubeVideoEdit() {
    FlutterYoutube.onVideoEnded.listen((onData) {
      //perform your action when video playing is done
    });

    FlutterYoutube.playYoutubeVideoByUrl(
      apiKey: "<API_KEY>",
      videoUrl: textEditingControllerUrl.text,
    );
  }

  void playYoutubeVideoIdEdit() {
    FlutterYoutube.onVideoEnded.listen((onData) {
      //perform your action when video playing is done
    });

    FlutterYoutube.playYoutubeVideoById(
      apiKey: "<API_KEY>",
      videoId: textEditingControllerId.text,
    );
  }

  void playYoutubeVideoIdEditAuto() {
    FlutterYoutube.onVideoEnded.listen((onData) {
      //perform your action when video playing is done
    });

    FlutterYoutube.playYoutubeVideoById(
        apiKey: "<API_KEY>",
        videoId: textEditingControllerId.text,
        autoPlay: true);
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Youtube Player'),
        ),
        body: new SingleChildScrollView(
          child: new Column(
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new TextField(
                  controller: textEditingControllerUrl,
                  decoration:
                      new InputDecoration(labelText: "Enter Youtube URL"),
                ),
              ),
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new RaisedButton(
                    child: new Text("Play Video By Url"),
                    onPressed: playYoutubeVideoEdit),
              ),
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new RaisedButton(
                    child: new Text("Play Default Video"),
                    onPressed: playYoutubeVideo),
              ),
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new TextField(
                  controller: textEditingControllerId,
                  decoration: new InputDecoration(
                      labelText: "Youtube Video Id (wgTBLj7rMPM)"),
                ),
              ),
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new RaisedButton(
                    child: new Text("Play Video By Id"),
                    onPressed: playYoutubeVideoIdEdit),
              ),
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new RaisedButton(
                    child: new Text("Auto Play Video By Id"),
                    onPressed: playYoutubeVideoIdEditAuto),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
