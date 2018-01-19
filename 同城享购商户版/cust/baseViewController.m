//
//  baseViewController.m
//  同城享购
//
//  Created by 庄园 on 2017/11/8.
//  Copyright © 2017年 庄园. All rights reserved.
//

#import "baseViewController.h"

@interface baseViewController ()

@end

@implementation baseViewController

-(UIImageView *)navView{
    if (!_navView) {
        if (IPHONE_X ) {
             _navView=[[UIImageView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 88)];
        }else{
            _navView=[[UIImageView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 64)];
        }
        // _navView.backgroundColor=UIColorFromRGBA(53, 93, 71, 1);
        [_navView setImage:[self createImageWithColor:UIColorFromRGBA(68, 195, 34, 1) andSize:CGSizeMake(1, 1)]];
        _navView.userInteractionEnabled=YES;
    }
    return _navView;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    
    return UIStatusBarStyleLightContent;
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //去掉分割线
    self.navigationController.navigationBar.shadowImage = [UIImage new];
}

- (void)setTitle:(NSString *)str{
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 12+20, SCREEN_WIDTH-40, 20)];
    titleLabel.font = [UIFont systemFontOfSize:17];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = str;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.navView addSubview:titleLabel];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorFromRGBA(247, 247, 247, 1);
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.view addSubview:self.navView];
    [self configBar];
}
- (void)configBar{
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [leftBtn setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    leftBtn.frame = CGRectMake(0, 0, 30, 30);
    [leftBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *letfBarItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = letfBarItem;
}
- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)contitle:(NSString *)viewtitle{
    
    UILabel *customLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    [customLab setTextColor:[UIColor whiteColor]];
    [customLab setText:viewtitle];
    customLab.textAlignment = NSTextAlignmentCenter;
    customLab.font = [UIFont systemFontOfSize:17];
   // customLab.backgroundColor = [UIColor redColor];
    self.navigationItem.titleView = customLab;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UIImage*)createImageWithColor:(UIColor*)color andSize:(CGSize)size
{
    CGRect rect=CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
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
