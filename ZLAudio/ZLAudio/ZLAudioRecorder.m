//
//  ZLAudioRecorder.m
//  ZLAudio
//
//  Created by ZhangLiang on 2022/8/27.
//

#import "ZLAudioRecorder.h"
#import <AVFoundation/AVFoundation.h>

#define kMaxminuDuration 60

@interface ZLAudioRecorder () <AVAudioRecorderDelegate>

@property (nonatomic,strong) AVAudioRecorder *recorder;

@property (nonatomic,strong) AVAudioSession *audioSession;
@property (nonatomic,copy) NSString *audioFile;

@end

@implementation ZLAudioRecorder

- (AVAudioRecorder *)recorder{
    if (_recorder == nil) {
        NSString *globallyUniqueString = [NSProcessInfo processInfo].globallyUniqueString;
        self.audioFile = [NSTemporaryDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.caf", globallyUniqueString]];
        
        NSMutableDictionary *recordSettings = [[NSMutableDictionary alloc] init];
        recordSettings[AVFormatIDKey] = @(kAudioFormatAppleLossless);
        recordSettings[AVSampleRateKey] = @44100.0f;
        recordSettings[AVNumberOfChannelsKey] = @2;
        
        // Initiate and prepare the recorder
        _recorder = [[AVAudioRecorder alloc] initWithURL:[NSURL fileURLWithPath:self.audioFile] settings:recordSettings error:nil];
        _recorder.delegate = self;
        _recorder.meteringEnabled = YES;
    }
    
    return _recorder;
}

// 开始录音
- (void)startRecorder {
    [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.audioSession = [AVAudioSession sharedInstance];
            [self.audioSession setActive:YES error:nil];
            [self.audioSession setCategory:AVAudioSessionCategoryRecord error:nil];
            [self.recorder prepareToRecord];
            [self.recorder recordForDuration:kMaxminuDuration];
        });
    }];
}

// 暂停录音
- (void)pauseRecorder {
    [self.recorder pause];
}

// 停止录音
- (void)stopRecorder {
    [self.recorder stop];
}

#pragma mark - AVAudioRecorderDelegate
- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag {
    NSLog(@"audioRecorderDidFinishRecording - successfully");
    if (flag) {
        if (self.completionBlock) {
            self.completionBlock([NSData dataWithContentsOfURL:recorder.url]);
        }
    }
}

@end
