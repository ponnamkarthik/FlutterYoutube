package io.github.ponnamkarthik.flutteryoutube;

import android.app.Activity;
import android.content.Intent;
import android.util.Log;

import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/**
 * FlutterYoutubePlugin
 */
public class FlutterYoutubePlugin implements MethodCallHandler {

  Activity activity;

  FlutterYoutubePlugin(Activity act) {
    activity = act;
  }
  /**
   * Plugin registration.
   */
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "PonnamKarthik/flutter_youtube");
    channel.setMethodCallHandler(new FlutterYoutubePlugin(registrar.activity()));
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    if (call.method.equals("playYoutubeVideo")) {
      String apiKey = call.argument("api");
      String videoId = call.argument("id");
      boolean fullScreen = call.argument("fullScreen");


      Intent playerIntent = new Intent(activity, PlayerActivity.class);
      playerIntent.putExtra("api", apiKey);
      playerIntent.putExtra("videoId", videoId);
      playerIntent.putExtra("fullScreen", fullScreen);

      activity.startActivity(playerIntent);
    } else {
      result.notImplemented();
    }
  }
}
