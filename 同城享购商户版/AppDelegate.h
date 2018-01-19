//
//  AppDelegate.h
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/11/22.
//  Copyright © 2017年 韩先炜. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,AVAudioPlayerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic , strong) AVAudioPlayer *audioPlayer;

@property (nonatomic,strong) NSString *pushIdString;

@property (nonatomic,assign) BOOL isExitByUseer;

@end

