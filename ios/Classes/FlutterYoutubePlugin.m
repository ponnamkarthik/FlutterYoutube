#import <XCDYouTubeKit/XCDYouTubeKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import "FlutterYoutubePlugin.h"

static NSString *const PLATFORM_CHANNEL = @"PonnamKarthik/flutter_youtube";

@implementation FlutterYoutubePlugin

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel *shareChannel =
    [FlutterMethodChannel methodChannelWithName:PLATFORM_CHANNEL
                                binaryMessenger:registrar.messenger];
    
    [shareChannel setMethodCallHandler:^(FlutterMethodCall *call, FlutterResult result) {
        if ([@"playYoutubeVideo" isEqualToString:call.method]) {
            NSDictionary *arguments = [call arguments];
            NSString *youtubeId = arguments[@"id"];

            if (youtubeId.length == 0) {
                result(
                       [FlutterError errorWithCode:@"error" message:@"Non-empty text expected for id" details:nil]);
                return;
            }
            
            NSString *api = arguments[@"api"];
            
            if (api.length == 0) {
                result(
                       [FlutterError errorWithCode:@"error" message:@"Non-empty text expected for api" details:nil]);
                return;
            }
            
            // Boolean fullscreen = arguments[@"originY"];
            
            [self playVideo: youtubeId];
            
            result(nil);
        } else {
            result(FlutterMethodNotImplemented);
        }
    }];
}

+ (void) playVideo: (NSString *) ytid {
    /*XCDYouTubeVideoPlayerViewController *videoPlayerViewController = [[XCDYouTubeVideoPlayerViewController alloc] initWithVideoIdentifier:ytid];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayerPlaybackDidFinish:) name:MPMoviePlayerPlaybackDidFinishNotification object:videoPlayerViewController.moviePlayer];
    [[[[[UIApplication sharedApplication] delegate] window] rootViewController] presentMoviePlayerViewControllerAnimated: videoPlayerViewController];*/
    
    AVPlayerViewController *playerViewController = [AVPlayerViewController new];
    [[UIApplication sharedApplication].windows.firstObject.rootViewController presentViewController:playerViewController animated:YES completion:nil];
    
    __weak AVPlayerViewController *weakPlayerViewController = playerViewController;
    [[XCDYouTubeClient defaultClient] getVideoWithIdentifier:ytid completionHandler:^(XCDYouTubeVideo * _Nullable video, NSError * _Nullable error) {
    if (video)
    {
        NSDictionary *streamURLs = video.streamURLs;
        NSURL *streamURL = streamURLs[XCDYouTubeVideoQualityHTTPLiveStreaming] ?: streamURLs[@(XCDYouTubeVideoQualityHD720)] ?: streamURLs[@(XCDYouTubeVideoQualityMedium360)] ?: streamURLs[@(XCDYouTubeVideoQualitySmall240)];
        weakPlayerViewController.player = [AVPlayer playerWithURL:streamURL];
        [weakPlayerViewController.player play];
    }
    else
    {
        [[UIApplication sharedApplication].windows.firstObject.rootViewController dismissViewControllerAnimated:YES completion:nil];
    }
}];
}

+ (void) moviePlayerPlaybackDidFinish:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:notification.object];
    MPMovieFinishReason finishReason = [notification.userInfo[MPMoviePlayerPlaybackDidFinishReasonUserInfoKey] integerValue];
    if (finishReason == MPMovieFinishReasonPlaybackError)
    {
        NSError *error = notification.userInfo[XCDMoviePlayerPlaybackDidFinishErrorUserInfoKey];
        // Handle error
    }
}

@end
