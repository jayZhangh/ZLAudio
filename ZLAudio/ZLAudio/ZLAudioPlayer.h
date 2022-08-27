//
//  ZLAudioPlayer.h
//  ZLAudio
//
//  Created by ZhangLiang on 2022/8/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZLAudioPlayer : UIViewController

/**
 开始播放
 @param audioData 录音文件
 */
- (void)playWithAudioData:(NSData *)audioData;

/**
 暂停播放
 */
- (void)pauseAudio;

/**
 停止播放
 */
- (void)stopAudio;

@end

NS_ASSUME_NONNULL_END
