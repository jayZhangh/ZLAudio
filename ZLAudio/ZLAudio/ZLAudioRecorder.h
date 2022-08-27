//
//  ZLAudioRecorder.h
//  ZLAudio
//
//  Created by ZhangLiang on 2022/8/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZLAudioRecorder : UIViewController

@property (nonatomic, copy) void (^completionBlock)(NSData *audio);

/**
 开始录音
 */
- (void)startRecorder;

/**
 暂停录音
 */
- (void)pauseRecorder;

/**
 停止录音
 */
- (void)stopRecorder;

@end

NS_ASSUME_NONNULL_END
