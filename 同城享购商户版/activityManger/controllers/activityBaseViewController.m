//
//  activityBaseViewController.m
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/12/8.
//  Copyright © 2017年 韩先炜. All rights reserved.
//

#import "activityBaseViewController.h"

#import "activityStateViewController.h"
#import "hxwSegmentView.h"

@interface activityBaseViewController ()

@end

@implementation activityBaseViewController

- (void)viewDidLoad {
        [super viewDidLoad];
        [self contitle:@"活动管理"];
        activityStateViewController *activityOn = [[activityStateViewController alloc]init];
        activityOn.index = 0;
    
        activityStateViewController *activityWilling = [[activityStateViewController alloc]init];
        activityWilling.index = 1;
    
        activityStateViewController *activityOver = [[activityStateViewController alloc]init];
        activityOver.index =2;
    
        NSArray *vcArray = @[activityOn,activityWilling,activityOver];
    
        hxwSegmentView *seg = [[hxwSegmentView alloc]initWithFrame:CGRectMake(0,SafeAreaTopHeight,SCREEN_WIDTH,SCREEN_HEIGHT-SafeAreaTopHeight) buttonName:@[@"进行中",@"未开始",@"已结束"] contrllers:vcArray parentController:self];
        seg.clickIndex = self.index;
        [self.view addSubview:seg];
    
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
