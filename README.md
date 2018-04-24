# flutter_youtube

Flutter Plugin to play youtube Videos using youtube player api (android)

Supported : Android

## How to Use

```yaml
dependencies:
  flutter_youtube: "^0.1.2"
```

###Imports

```dart
import 'package:flutter_youtube/flutter_youtube.dart';
```

###Code

```dart
FlutterYoutube.playYoutubeVideoByUrl(
  apiKey: "<API_KEY>",
  videoUrl: "<Youtube Video URL>",
  fullScreen: true //default false
);
```

```dart
FlutterYoutube.playYoutubeVideoById(
  apiKey: "<API_KEY>",
  videoId: "<Youtube Video ID>",
  fullScreen: true //default false
);
```

Key | Value
------------ | -------------
apiKey | String (Not Null)
videoUrl | String (Not Null)
videoId | String (Not Null)
fullScreen | Boolean (Optional)(Default = false)
