//
//  AppDelegate.m
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/11/22.
//  Copyright © 2017年 韩先炜. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "JTNavigationController.h"
#import "JTBaseNavigationController.h"
#import "homeViewController.h"
#import "BPush.h"
#import "keepData.h"
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

static BOOL isBackGroundActivateApplication;

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [UIApplication sharedApplication].statusBarHidden=NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    //设置 是否用户自己 选择退出登陆 初始值  标记用户是否手动退出了 但是 没有杀死app的情况
    del.isExitByUseer = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(slientLogin:) name:@"slientLogin" object:nil];
    JTBaseNavigationController * rootView = nil;

    if ([keepData getLoginState]) {
        homeViewController *firsttab = [[homeViewController alloc] init];
        JTNavigationController *firstNav = [[JTNavigationController alloc] initWithRootViewController:firsttab];
        rootView = [[JTBaseNavigationController alloc]initWithRootViewController:firstNav];
        self.window.rootViewController = rootView;
    }else{
        LoginViewController *loginVC = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
        //如果用户不是第一次登陆 则使用先前登陆保存下来的uuid作为参数 如果是第一次登陆 则进行uuid的获取并进行登陆
        
        if ([keepData getUUID].length!=0) {
            loginVC.LoginUUID = [keepData getUUID];
        }else{
             loginVC.LoginUUID = [self gen_uuid];
        }
        self.window.rootViewController = loginVC;
    }
    
    //添加获取状态的
    [self requestPush];
    

    // iOS10 下需要使用新的 API
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0) {
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
        UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
        
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert + UNAuthorizationOptionSound + UNAuthorizationOptionBadge)
                              completionHandler:^(BOOL granted, NSError * _Nullable error) {
                                  // Enable or disable features based on authorization.
                                  if (granted) {
                                      [application registerForRemoteNotifications];
                                  }
                              }];
#endif
    }
    else if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        UIUserNotificationType myTypes = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:myTypes categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }else {
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTypes];
    }
    
#warning 上线 AppStore 时需要修改BPushMode为BPushModeProduction 需要修改Apikey为自己的Apikey
    
    // 在 App 启动时注册百度云推送服务，需要提供 Apikey
    [BPush registerChannel:launchOptions apiKey:@"FD8g4fhk7sMHaN6DC3YW6vci" pushMode:BPushModeProduction withFirstAction:@"打开" withSecondAction:@"回复" withCategory:@"test" useBehaviorTextInput:YES isDebug:YES];
    // App 是用户点击推送消息启动
    NSDictionary *userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    
    if (userInfo) {
        NSLog(@"从消息启动:%@",userInfo);
        [BPush handleNotification:userInfo];
    }
    
    //角标清0
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    return YES;
    
}

// 此方法是 用户点击了通知，应用在前台 或者开启后台并且应用在后台 时调起
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    
    NSNotification *notification =[NSNotification notificationWithName:@"InfoNotification" object:nil userInfo:nil];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    
    NSLog(@"收到推送==>%@",userInfo);
    NSDictionary *result=[userInfo objectForKey:@"aps"];
    NSString* alert= [result objectForKey:@"alert"];
    NSLog(@"推送==>%@",alert);
   
    [self playSound:alert];
    
    // 打印到日志 textView 中
    
    NSLog(@"********** iOS7.0之后 background **********");
   // NSLog(@"state%@",application.applicationState);
    
    //杀死状态下，直接跳转到跳转页面。
    if (application.applicationState == UIApplicationStateInactive && !isBackGroundActivateApplication)
    {
         // 根视图是nav 用push 方式跳转
        //[_tabBarCtr.selectedViewController pushViewController:skipCtr animated:YES];
        NSLog(@"applacation is unactive ===== %@",userInfo);
        /*
         // 根视图是普通的viewctr 用present跳转
         [_tabBarCtr.selectedViewController presentViewController:skipCtr animated:YES completion:nil]; */
    }
    // 应用在后台。当后台设置aps字段里的 content-available 值为 1 并开启远程通知激活应用的选项
    if (application.applicationState == UIApplicationStateBackground) {
        NSLog(@"background is Activated Application ");
        // 此处可以选择激活应用提前下载邮件图片等内容。
        
    }
    NSLog(@"%@",userInfo);

    completionHandler(UIBackgroundFetchResultNewData);
    NSLog(@"backgroud : %@",userInfo);
    
}

// 在 iOS8 系统中，还需要添加这个方法。通过新的 API 注册推送服务
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    
    [application registerForRemoteNotifications];

}


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSLog(@"test:%@",deviceToken);
    [BPush registerDeviceToken:deviceToken];
    [BPush bindChannelWithCompleteHandler:^(id result, NSError *error) {
        
        // 需要在绑定成功后进行 settag listtag deletetag unbind 操作否则会失败
        NSLog(@"********");
        // 网络错误
        if (error) {
            return ;
        }
        if (result) {
            // 确认绑定成功
            if ([result[@"error_code"]intValue]!=0) {
                return;
            }
            // 获取channel_id
            NSString *myChannel_id = [BPush getChannelId];
            NSLog(@"==%@",myChannel_id);
            [keepData keepChannelid:myChannel_id];
            [BPush listTagsWithCompleteHandler:^(id result, NSError *error) {
                if (result) {
                    NSLog(@"result ============== %@",result);
                }
            }];
            [BPush setTag:@"Mytag" withCompleteHandler:^(id result, NSError *error) {
                if (result) {
                    NSLog(@"设置tag成功");
                }
            }];
        }
    }];
    
}

// 当 DeviceToken 获取失败时，系统会回调此方法
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"DeviceToken 获取失败，原因：%@",error);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    // App 收到推送的通知
    [BPush handleNotification:userInfo];
    NSLog(@"********** ios7.0之前 **********");
    // 应用在前台 或者后台开启状态下，不跳转页面，让用户选择。
    if (application.applicationState == UIApplicationStateActive || application.applicationState == UIApplicationStateBackground) {
        NSLog(@"acitve or background");
        UIAlertView *alertView =[[UIAlertView alloc]initWithTitle:@"收到一条消息" message:userInfo[@"aps"][@"alert"] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
    }
    else//杀死状态下，直接跳转到跳转页面。
    {
      //  SkipViewController *skipCtr = [[SkipViewController alloc]init];
       // [_tabBarCtr.selectedViewController pushViewController:skipCtr animated:YES];
    }
    
   // [self.viewController addLogString:[NSString stringWithFormat:@"Received Remote Notification :\n%@",userInfo]];
    
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    NSLog(@"接收本地通知啦！！！");
    [BPush showLocalNotificationAtFront:notification identifierKey:nil];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//开启一个线程去访问
- (void)requestPush{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
        
        while (TRUE) {
            
            // 每隔5秒执行一次（当前线程阻塞5秒）
            [NSThread sleepForTimeInterval:5];
            [[UIApplication sharedApplication] cancelAllLocalNotifications];
            
            //如网络请求
            NSMutableDictionary *parmas = [[NSMutableDictionary alloc]init];
            parmas[@"uuid"] = [keepData getUUID];
            parmas[@"shopId"] =  @([SPAccountTool account].shopId);
            if (!del.isExitByUseer && [keepData getUUID].length!=0) {
                [URLRequest postWithURL:@"shop/push/last" params:parmas success:^(NSURLSessionDataTask *task, id responseObject) {
                    NSLog(@"\n%@ \n%@",responseObject[@"id"],del.pushIdString);
                    NSString *idString = [NSString stringWithFormat:@"%@",responseObject[@"id"]];
                    if (del.pushIdString.length ==0) {
                        del.pushIdString = idString;
                    }else{
                        if (![del.pushIdString isEqualToString:idString]) {
                             [self playSound:responseObject[@"title"]];
                            del.pushIdString = idString;
                        }
                    }
                } failure:^(NSURLSessionDataTask *task, NSError *error) {
                    NSLog(@"%@",error);
                }];
            }
        };
    });
}

- (void)playSound:(NSString *)alert{
    NSLog(@"alert:%@",alert);
    
    NSNotification *notification =[NSNotification notificationWithName:@"InfoNotification" object:nil userInfo:nil];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    if([alert isEqualToString:@"新的订单提醒"]){
        AVAudioSession *session = [AVAudioSession sharedInstance];
        [session setActive:YES error:nil];
        [session setCategory:AVAudioSessionCategoryPlayback error:nil];
        // 1.获取要播放音频文件的URL
        NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"take" withExtension:@"m4a"];
        NSLog(@"音频播放器文件地址:%@",fileURL);
        // 2.创建 AVAudioPlayer 对象
        self.audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:fileURL error:nil];
        // 4.设置循环播放
        self.audioPlayer.numberOfLoops = 0;
        self.audioPlayer.delegate = self;
        self.audioPlayer.volume=2;
        // 5.开始播放
        [self.audioPlayer play];
    }
    if([alert isEqualToString:@"订单退款提醒"]){
        AVAudioSession *session = [AVAudioSession sharedInstance];
        [session setActive:YES error:nil];
        [session setCategory:AVAudioSessionCategoryPlayback error:nil];
        
        
        // 1.获取要播放音频文件的URL
        NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"refund" withExtension:@"m4a"];
        NSLog(@"音频播放器文件地址:%@",fileURL);
        // 2.创建 AVAudioPlayer 对象
        self.audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:fileURL error:nil];
        // 4.设置循环播放
        self.audioPlayer.numberOfLoops = 0;
        self.audioPlayer.delegate = self;
        self.audioPlayer.volume=2;
        // 5.开始播放
        [self.audioPlayer play];
        
    }
    
    if([alert isEqualToString:@"超时未接单提醒"]){
        AVAudioSession *session = [AVAudioSession sharedInstance];
        [session setActive:YES error:nil];
        [session setCategory:AVAudioSessionCategoryPlayback error:nil];
        // 1.获取要播放音频文件的URL
        NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"outtime" withExtension:@"m4a"];
        NSLog(@"音频播放器文件地址:%@",fileURL);
        // 2.创建 AVAudioPlayer 对象
        self.audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:fileURL error:nil];
        // 3.打印歌曲信息
        // 4.设置循环播放
        self.audioPlayer.numberOfLoops = 0;
        self.audioPlayer.delegate = self;
        self.audioPlayer.volume=2;
        // 5.开始播放
        [self.audioPlayer play];
    }
}

- (NSString *) gen_uuid
{
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    CFRelease(uuid_ref);
    NSString *uuid = [NSString stringWithString:(__bridge NSString*)uuid_string_ref];
    CFRelease(uuid_string_ref);
    return uuid;
}

@end
