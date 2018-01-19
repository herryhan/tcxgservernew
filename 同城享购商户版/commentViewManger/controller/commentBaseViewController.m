//
//  commentBaseViewController.m
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/12/9.
//  Copyright © 2017年 韩先炜. All rights reserved.
//

#import "commentBaseViewController.h"
#import "commentsViewController.h"
#import "hxwSegmentView.h"

@interface commentBaseViewController ()

@end

@implementation commentBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self contitle:@"评论管理"];
    commentsViewController *activityOn = [[commentsViewController alloc]init];
    activityOn.index = 1;
    
    commentsViewController *activityWilling = [[commentsViewController alloc]init];
    activityWilling.index = 2;
    
    commentsViewController *activityOver = [[commentsViewController alloc]init];
    activityOver.index =0;
    
    NSArray *vcArray = @[activityOn,activityWilling,activityOver];
    
    hxwSegmentView *seg = [[hxwSegmentView alloc]initWithFrame:CGRectMake(0,SafeAreaTopHeight,SCREEN_WIDTH,SCREEN_HEIGHT-SafeAreaTopHeight) buttonName:@[@"未回复",@"差评",@"全部评论"] contrllers:vcArray parentController:self];
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
