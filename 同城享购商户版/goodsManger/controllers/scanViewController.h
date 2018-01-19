//
//  scanViewController.h
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/11/29.
//  Copyright © 2017年 韩先炜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "baseViewController.h"

@interface scanViewController :baseViewController  <AVCaptureMetadataOutputObjectsDelegate>

@property(nonatomic, strong)AVCaptureSession *session;//输入输出的中间桥梁

@property (nonatomic, strong) void(^scanResult)(id result);

@end
