import 'package:meta/meta.dart';

import 'package:flutter/services.dart';

class FlutterYoutube {
  static const MethodChannel _channel =
      const MethodChannel('flutter_youtube');

  static String getIdFromUrl(String url, [bool trimWhitespaces = true]) {

    if(url == null || url.length == 0)
      return null;

    if(trimWhitespaces)
      url = url.trim();

    for(var exp in _regexps) {
      Match match = exp.firstMatch(url);
      if(match != null && match.groupCount >= 1)
        return match.group(1);
    }

    return null;
  }

  static List<RegExp> _regexps = [
    new RegExp(r"^https:\/\/(?:www\.|m\.)?youtube\.com\/watch\?v=([_\-a-zA-Z0-9]{11}).*$"),
    new RegExp(r"^https:\/\/youtu\.be\/([_\-a-zA-Z0-9]{11}).*$")
  ];

  static void playYoutubeVideoByUrl({@required String apiKey, @required String videoUrl, bool fullScreen=false}) {

    if(apiKey.isEmpty || apiKey == null) {
      throw "Invalid API Key";
    }

    if(videoUrl == null || videoUrl.isEmpty) {
      throw "Invalid Youtube URL";
    }

    String id = getIdFromUrl(videoUrl);

    if(id == null) {
      throw "Invalid Youtube URL";
    }

    final Map<String, dynamic> params = <String, dynamic> {
      'api': apiKey,
      'id': id,
      'fullScreen': fullScreen
    };
    _channel.invokeMethod('playYoutubeVideo', params);
  }

  static void playYoutubeVideoById({@required String apiKey, @required String videoId, bool fullScreen=false}) {

    if(apiKey.isEmpty || apiKey == null) {
      throw "Invalid API Key";
    }

    if(videoId == null || videoId.isEmpty) {
      throw "Invalid Youtube URL";
    }


    final Map<String, dynamic> params = <String, dynamic> {
      'api': apiKey,
      'id': videoId,
      'fullScreen': fullScreen
    };
    _channel.invokeMethod('playYoutubeVideo', params);
  }



}
