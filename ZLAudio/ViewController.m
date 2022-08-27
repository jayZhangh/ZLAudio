//
//  ViewController.m
//  ZLAudio
//
//  Created by ZhangLiang on 2022/8/27.
//

#import "ViewController.h"
#import "ZLAudioRecorder.h"
#import "ZLAudioPlayer.h"

@interface ViewController ()
{
    ZLAudioRecorder *_recorder;
    ZLAudioPlayer *_player;
    NSData *_audioData;
}

- (IBAction)startAction:(id)sender;
- (IBAction)pauseAction:(id)sender;
- (IBAction)stopAction:(id)sender;
- (IBAction)playAction:(id)sender;
- (IBAction)pausePlayAction:(id)sender;
- (IBAction)stopPlayAction:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _recorder = [[ZLAudioRecorder alloc] init];
    _recorder.completionBlock = ^(NSData * _Nonnull audio) {
        self->_audioData = audio;
    };
    
    _player = [[ZLAudioPlayer alloc] init];
}

- (IBAction)stopPlayAction:(id)sender {
    [_player stopAudio];
}

- (IBAction)pausePlayAction:(id)sender {
    [_player pauseAudio];
}

- (IBAction)playAction:(id)sender {
    [_player playWithAudioData:_audioData];
}

- (IBAction)stopAction:(id)sender {
    [_recorder stopRecorder];
}

- (IBAction)pauseAction:(id)sender {
    [_recorder pauseRecorder];
}

- (IBAction)startAction:(id)sender {
    [_recorder startRecorder];
}

@end
