import 'dart:async';
import 'package:meta/meta.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class FlutterYoutube {
  static const MethodChannel _channel =
      MethodChannel('PonnamKarthik/flutter_youtube');

  static const EventChannel _stream =
      EventChannel('PonnamKarthik/flutter_youtube_stream');

  static String getIdFromUrl(String url, [bool trimWhitespaces = true]) {
    if (url == null || url.isEmpty) {
      return null;
    }

    if (trimWhitespaces) {
      url = url.trim();
    }

    for (RegExp exp in _regexps) {
      final Match match = exp.firstMatch(url);
      if (match != null && match.groupCount >= 1) {
        return match.group(1);
      }
    }

    return null;
  }

  static final List<RegExp> _regexps = [
    RegExp(
        r'^https:\/\/(?:www\.|m\.)?youtube\.com\/watch\?v=([_\-a-zA-Z0-9]{11}).*$'),
    RegExp(
        r'^https:\/\/(?:www\.|m\.)?youtube(?:-nocookie)?\.com\/embed\/([_\-a-zA-Z0-9]{11}).*$'),
    RegExp(r'^https:\/\/youtu\.be\/([_\-a-zA-Z0-9]{11}).*$')
  ];

  static playYoutubeVideoByUrl({
    @required String apiKey,
    @required String videoUrl,
    bool autoPlay = false,
    bool fullScreen = false,
    bool appBarVisible = false,
    Color appBarColor = Colors.black,
    Color backgroundColor = Colors.black,
  }) {
    if (apiKey.isEmpty || apiKey == null) {
      throw 'Invalid API Key';
    }

    if (videoUrl == null || videoUrl.isEmpty) {
      throw 'Invalid Youtube URL';
    }

    final String id = getIdFromUrl(videoUrl);

    if (id == null) {
      throw 'Error extracting Youtube id from URL';
    }

    final Map<String, dynamic> params = <String, dynamic>{
      'api': apiKey,
      'id': id,
      'autoPlay': autoPlay,
      'fullScreen': fullScreen,
      'appBarVisible': appBarVisible,
      'appBarColor': parseColorToHex(appBarColor),
      'backgroundColor': parseColorToHex(backgroundColor),
    };
    _channel.invokeMethod('playYoutubeVideo', params);
  }

  static playYoutubeVideoById({
    @required String apiKey,
    @required String videoId,
    bool autoPlay = false,
    bool fullScreen = false,
    bool appBarVisible = false,
    Color appBarColor = Colors.grey,
    Color backgroundColor = Colors.black,
  }) {
    if (apiKey.isEmpty || apiKey == null) {
      throw 'Invalid API Key';
    }

    if (videoId == null || videoId.isEmpty) {
      throw 'Invalid Youtube URL';
    }

    final Map<String, dynamic> params = <String, dynamic>{
      'api': apiKey,
      'id': videoId,
      'autoPlay': autoPlay,
      'fullScreen': fullScreen,
      'appBarVisible': appBarVisible,
      'appBarColor': parseColorToHex(appBarColor),
      'backgroundColor': parseColorToHex(backgroundColor),
    };
    _channel.invokeMethod('playYoutubeVideo', params);
  }

  Stream<String> done;

  static Stream<String> get onVideoEnded {
    final Stream<String> d =
        _stream.receiveBroadcastStream().map<String>((element) => element);
    return d;
  }

  static int parseColorToHex(Color color) {
    return int.parse('0xFF' + color.value.toRadixString(16).padLeft(8, '0'));
  }
}
