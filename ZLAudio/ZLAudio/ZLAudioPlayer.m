//
//  ZLAudioPlayer.m
//  ZLAudio
//
//  Created by ZhangLiang on 2022/8/27.
//

#import "ZLAudioPlayer.h"
#import <AVFoundation/AVFoundation.h>

@interface ZLAudioPlayer () <AVAudioPlayerDelegate>

@property (nonatomic,strong) AVAudioSession *audioSession;
@property (nonatomic, strong) AVAudioPlayer *player;

@end

@implementation ZLAudioPlayer

- (void)playWithAudioData:(NSData *)audioData {
    [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.audioSession = [AVAudioSession sharedInstance];
            [self.audioSession setActive:YES error:nil];
            [self.audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
            
            if (self->_player == nil) {
                NSError *error = nil;
                // 创建AVAudioPlayer对象
                self->_player = [[AVAudioPlayer alloc] initWithData:audioData error:&error];
                if (error) {
                    NSLog(@"%@", error.localizedDescription);
                    return;
                }
                
                (self->_player).delegate = self;
            }
            
            // 准备播放（缓冲，提高播放的流畅性）
            [self.player prepareToPlay];
            [self.player play];
        });
    }];
}

// 暂停播放，暂停后再开始从暂停的地方开始
- (void)pauseAudio {
    [self.player pause];
}

// 停止播放，停止后再开始从头开始
- (void)stopAudio {
    [self.player stop];
    self.player = nil;
}

#pragma mark - AVAudioPlayerDelegate
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    NSLog(@"audioPlayerDidFinishPlaying - successfully");
}

/* if an error occurs while decoding it will be reported to the delegate. */
- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError * __nullable)error {
    NSLog(@"audioPlayerDecodeErrorDidOccur - error");
}

@end
