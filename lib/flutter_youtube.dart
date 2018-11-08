import 'dart:async';

import 'package:meta/meta.dart';
import 'package:flutter/services.dart';

class FlutterYoutube {
  static const MethodChannel _channel =
      const MethodChannel('PonnamKarthik/flutter_youtube');

  static const EventChannel _stream =
      const EventChannel('PonnamKarthik/flutter_youtube_stream');

  static String getIdFromUrl(String url, [bool trimWhitespaces = true]) {
    if (url == null || url.length == 0) return null;

    if (trimWhitespaces) url = url.trim();

    for (var exp in _regexps) {
      Match match = exp.firstMatch(url);
      if (match != null && match.groupCount >= 1) return match.group(1);
    }

    return null;
  }

  static List<RegExp> _regexps = [
    new RegExp(
        r"^https:\/\/(?:www\.|m\.)?youtube\.com\/watch\?v=([_\-a-zA-Z0-9]{11}).*$"),
    new RegExp(
        r"^https:\/\/(?:www\.|m\.)?youtube(?:-nocookie)?\.com\/embed\/([_\-a-zA-Z0-9]{11}).*$"),
    new RegExp(r"^https:\/\/youtu\.be\/([_\-a-zA-Z0-9]{11}).*$")
  ];

  static playYoutubeVideoByUrl(
      {@required String apiKey,
      @required String videoUrl,
        bool autoPlay = false,
      bool fullScreen = false}) {
    if (apiKey.isEmpty || apiKey == null) {
      throw "Invalid API Key";
    }

    if (videoUrl == null || videoUrl.isEmpty) {
      throw "Invalid Youtube URL";
    }

    String id = getIdFromUrl(videoUrl);

    if (id == null) {
      throw "Error extracting Youtube id from URL";
    }

    final Map<String, dynamic> params = <String, dynamic>{
      'api': apiKey,
      'id': id,
      'autoPlay': autoPlay,
      'fullScreen': fullScreen
    };
    _channel.invokeMethod('playYoutubeVideo', params);
  }

  static playYoutubeVideoById(
      {@required String apiKey,
      @required String videoId,
        bool autoPlay = false,
      bool fullScreen = false}) {
    if (apiKey.isEmpty || apiKey == null) {
      throw "Invalid API Key";
    }

    if (videoId == null || videoId.isEmpty) {
      throw "Invalid Youtube URL";
    }

    final Map<String, dynamic> params = <String, dynamic>{
      'api': apiKey,
      'id': videoId,
      'autoPlay': autoPlay,
      'fullScreen': fullScreen
    };
    _channel.invokeMethod('playYoutubeVideo', params);
  }

  Stream<String> done;

  Stream<String> get onVideoEnded {

    var d = _stream
        .receiveBroadcastStream()
        .map<String>(
            (element) => element);
    return d;
  }
}
