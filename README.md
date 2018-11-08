# flutter_youtube

Flutter Plugin to play youtube Videos using youtube player api (android)

Supported
* Android
* iOS

## How to Use

```yaml
dependencies:
  flutter_youtube: "^1.1.4"
```

###Imports

```dart
import 'package:flutter_youtube/flutter_youtube.dart';
```

###Code

```dart
var youtube = new FlutterYoutube();

youtube.playYoutubeVideoByUrl(
  apiKey: "<API_KEY>",
  videoUrl: "<Youtube Video URL>",
  autoPlay: true, //default falase
  fullScreen: true //default false
);
```

```dart
FlutterYoutube.playYoutubeVideoById(
  apiKey: "<API_KEY>",
  videoId: "<Youtube Video ID>",
  autoPlay: true, //default falase
  fullScreen: true //default false
);
```

### Video End Listener

> *Note Right now only supported in android

```dart
youtube.onVideoEnded.listen((onData) {
  //perform your action when video playing is done
});
```

Key | Value
------------ | -------------
apiKey | String (Not Null)
videoUrl | String (Not Null)
videoId | String (Not Null)
autoPlay | Boolean (Optional)(Default = false)
fullScreen | Boolean (Optional)(Default = false)
