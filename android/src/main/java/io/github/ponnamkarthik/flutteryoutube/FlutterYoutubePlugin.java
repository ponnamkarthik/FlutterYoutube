package io.github.ponnamkarthik.flutteryoutube;

import android.app.Activity;
import android.content.Intent;

import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/**
 * FlutterYoutubePlugin
 */
public class FlutterYoutubePlugin implements MethodCallHandler, EventChannel.StreamHandler {

  private static final String STREAM_CHANNEL_NAME = "PonnamKarthik/flutter_youtube_stream";
  private static final int YOUTUBE_PLAYER_RESULT = 6646;

  Activity activity;
  static EventChannel.EventSink events;

  FlutterYoutubePlugin(Activity act) {
    activity = act;
  }
  /**
   * Plugin registration.
   */
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "PonnamKarthik/flutter_youtube");
    channel.setMethodCallHandler(new FlutterYoutubePlugin(registrar.activity()));
    registrar.addActivityResultListener(new PluginRegistry.ActivityResultListener() {
      @Override
      public boolean onActivityResult(int i, int i1, Intent intent) {
        if(i == YOUTUBE_PLAYER_RESULT) {
          if(intent != null) {
            if(intent.getIntExtra("done", -1) == 0) {
              if(events != null) {
                events.success("done");
              }
            }
          }
        }
        return false;
      }
    });

    final EventChannel eventChannel = new EventChannel(registrar.messenger(), STREAM_CHANNEL_NAME);
    FlutterYoutubePlugin youtubeWithEventChannel = new FlutterYoutubePlugin(registrar.activity());
    eventChannel.setStreamHandler(youtubeWithEventChannel);
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {

    if (call.method.equals("playYoutubeVideo")) {
      String apiKey = call.argument("api");
      String videoId = call.argument("id");
      boolean autoPlay = call.argument("autoPlay");
      boolean fullScreen = call.argument("fullScreen");


      Intent playerIntent = new Intent(activity, PlayerActivity.class);
      playerIntent.putExtra("api", apiKey);
      playerIntent.putExtra("videoId", videoId);
      playerIntent.putExtra("autoPlay", autoPlay);
      playerIntent.putExtra("fullScreen", fullScreen);

      activity.startActivityForResult(playerIntent, YOUTUBE_PLAYER_RESULT);

    } else {
      result.notImplemented();
    }
  }

  @Override
  public void onListen(Object o, EventChannel.EventSink eventSink) {
    events = eventSink;
  }

  @Override
  public void onCancel(Object o) {
    events = null;
  }
}
