//
//  qrCodeViewController.m
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/12/2.
//  Copyright © 2017年 韩先炜. All rights reserved.
//

#import "qrCodeViewController.h"
#import <CoreImage/CoreImage.h>

@interface qrCodeViewController ()

@end

@implementation qrCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self contitle:@"店铺二维码"];
    [self uiconfig];
}
- (void)uiconfig{
    UIImageView *imagev = [[UIImageView alloc]initWithFrame:CGRectMake(50, (SCREEN_HEIGHT+100-SCREEN_WIDTH-SafeAreaTopHeight)/2, SCREEN_WIDTH-100, SCREEN_WIDTH-100)];
    
    // 1. 创建一个二维码滤镜实例(CIFilter)
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 滤镜恢复默认设置
    [filter setDefaults];
    
    // 2. 给滤镜添加数据
    NSString *string = [SPAccountTool account].code;
    NSLog(@"%@",string);
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    [filter setValue:data forKeyPath:@"inputMessage"];
    
    // 3. 生成二维码
    CIImage *image = [filter outputImage];
    
    // 4. 显示二维码
    imagev.image = [self createNonInterpolatedUIImageFormCIImage:image withSize:SCREEN_WIDTH-100];
    
    [self.view addSubview:imagev];
}

- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size {
    
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
