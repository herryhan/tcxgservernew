//
//  scanViewController.m
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/11/29.
//  Copyright © 2017年 韩先炜. All rights reserved.
//

#import "scanViewController.h"

@interface scanViewController ()

@end

@implementation scanViewController

#pragma mark -- 开始扫描
- (void)startScanWithSize:(CGFloat)sizeValue
{
    //获取摄像设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //创建输入流
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    //判断输入流是否可用
    if (input) {
        //创建输出流
        AVCaptureMetadataOutput * output = [[AVCaptureMetadataOutput alloc]init];
        //设置代理,在主线程里刷新,注意此时self需要签AVCaptureMetadataOutputObjectsDelegate协议
        [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        //初始化连接对象
        self.session = [[AVCaptureSession alloc]init];
        //高质量采集率
        [_session setSessionPreset:AVCaptureSessionPresetHigh];
        [_session addInput:input];
        [_session addOutput:output];
        //设置扫码支持的编码格式(如下设置条形码和二维码兼容)
        output.metadataObjectTypes = @[AVMetadataObjectTypeEAN13Code];
        //扫描区域大小的设置:(这部分也可以自定义,显示自己想要的布局)
        AVCaptureVideoPreviewLayer *layer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
        layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        //设置为宽高为200的正方形区域相对于屏幕居中
        layer.frame = CGRectMake(0,0,self.view.bounds.size.width,self.view.bounds.size.height);
        [self.view.layer insertSublayer:layer atIndex:0];
        //开始捕获图像:
        [_session startRunning];
    }
}

#pragma mark -- 调用扫描方法
- (void)viewDidLoad {
    [super viewDidLoad];
    //300为正方形扫描区域边长
    self.navView.hidden = YES;
    
    [self startScanWithSize:300];
    
    UIView *head=[[UIView alloc]initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, 45)];
    head.backgroundColor=[UIColor colorWithRed:50/255.0 green:58/255.0 blue:69/255.0 alpha:1];
    
    UIImageView *back=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"back.png"]];
    back.frame=CGRectMake(7, 7, 31, 31);
    UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(back)];
    [back addGestureRecognizer:tapGesturRecognizer];
    back.userInteractionEnabled=YES;
    [head addSubview:back];
    
    //[self.view addSubview:head];
    
    UIImageView *bg=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"scan"]];
    bg.frame=CGRectMake(0,0,self.view.bounds.size.width,self.view.bounds.size.height);
    [self.view addSubview:bg];
    
    
}

#pragma mark - 扫面结果在这个代理方法里获取到
-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    if (metadataObjects.count>0) {
        //获取到信息后停止扫描:
        [_session stopRunning];
        AVMetadataMachineReadableCodeObject *metaDataObject = [metadataObjects objectAtIndex:0];
        //输出扫描字符串:
        NSLog(@"%@", metaDataObject.stringValue);
        //移除扫描视图:
        AVCaptureVideoPreviewLayer *layer = (AVCaptureVideoPreviewLayer *)[[self.view.layer sublayers] objectAtIndex:0];
        [layer removeFromSuperlayer];
        
        //关闭页面并返回值
        NSMutableDictionary *paramas = [[NSMutableDictionary alloc]init];
        paramas[@"uuid"] = [keepData getUUID];
        paramas[@"code"] = metaDataObject.stringValue;
        [URLRequest postWithURL:@"sp/product/read/code" params:paramas success:^(NSURLSessionDataTask *task, id responseObject) {
            
                [self back];
                NSLog(@"%@",responseObject);
                _scanResult(responseObject);

        } failure:^(NSURLSessionDataTask *task, NSError *error) {
           
            NSLog(@"error :%@",error);
            
        }];
    }
}

-(void)back{
    NSLog(@"用户点击了返回按钮");
    [self.navigationController popViewControllerAnimated:YES];
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
