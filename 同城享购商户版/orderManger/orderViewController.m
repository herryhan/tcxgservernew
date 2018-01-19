//
//  orderViewController.m
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/12/5.
//  Copyright © 2017年 韩先炜. All rights reserved.
//

#import "orderViewController.h"
#import "waitingOrderViewController.h"
#import "onOrderViewController.h"
#import "overOrderViewController.h"
#import "allOrderViewController.h"
#import "hxwSegmentView.h"


@interface orderViewController ()

@end

@implementation orderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self contitle:@"订单"];
    waitingOrderViewController *waitVc = [[waitingOrderViewController alloc]init];
    waitVc.index = 0;
    
    waitingOrderViewController *onVC = [[waitingOrderViewController alloc]init];
    onVC.index = 1;
    
    waitingOrderViewController *overVc = [[waitingOrderViewController alloc]init];
    overVc.index =2;
    
    waitingOrderViewController *allVc = [[waitingOrderViewController alloc]init];
    allVc.index = 3;
    
    waitingOrderViewController *getBySelfVc = [[waitingOrderViewController alloc]init];
    getBySelfVc.index = 4;
    
    NSArray *vcArray = @[waitVc,onVC,getBySelfVc,overVc,allVc];
    
    hxwSegmentView *seg = [[hxwSegmentView alloc]initWithFrame:CGRectMake(0,SafeAreaTopHeight,SCREEN_WIDTH,SCREEN_HEIGHT-SafeAreaTopHeight) buttonName:@[@"待接单",@"派送中",@"自提单",@"退款中",@"已完成"] contrllers:vcArray parentController:self];
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
