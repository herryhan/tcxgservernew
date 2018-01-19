//
//  hxwSegmentView.m
//  一筹百应
//
//  Created by 庄园 on 17/10/12.
//  Copyright © 2017年 择善基金. All rights reserved.
//

#import "hxwSegmentView.h"
#import "UIScrollView+gestrue.h"

@interface hxwSegmentView ()

@property (nonatomic, strong) NSArray *buttonName;
@property (nonatomic, strong) UILabel *underLine;
@property (nonatomic, strong) UILabel *downLine;
@property (nonatomic, strong) UIButton *selectButton;
@property (nonatomic, strong) NSArray *controllers;
@property (nonatomic, strong) UIView *segmentView;
@property (nonatomic, strong) UIImageView *lineImageView;

@end

@implementation hxwSegmentView 

- (instancetype)initWithFrame:(CGRect)frame buttonName:(NSArray *)buttonName contrllers:(NSArray *)contrllers parentController:(UIViewController *)parentC {
    
    if (self = [super initWithFrame:frame]) {
        
        self.buttonName = buttonName;
        self.controllers = contrllers;
        
        // 创建segementView
        
        self.segmentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 48*KWidth_ScaleW)];
        self.segmentView.tag = 50;
        self.segmentView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.segmentView];
       
        
        //  创建segmentScrollV
        
        self.segmentScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 48*KWidth_ScaleW, SCREEN_WIDTH, frame.size.height - 48*KWidth_ScaleW)];
        self.segmentScrollV.contentSize = CGSizeMake(SCREEN_WIDTH * self.controllers.count, 0);
        self.segmentScrollV.showsHorizontalScrollIndicator = NO;
        self.segmentScrollV.pagingEnabled = YES;
        self.segmentScrollV.bounces = NO;
        self.segmentScrollV.delegate = self;
        
        [self addSubview:self.segmentScrollV];
        
        // 创建ViewController并添加到segmentScrollV
        
        for (int i = 0; i < self.controllers.count; i++) {
            
            UIViewController *contro = self.controllers[i];
            contro.view.frame = CGRectMake(i * SCREEN_WIDTH, 0, SCREEN_WIDTH, frame.size.height);
            [self.segmentScrollV addSubview:contro.view];
            [parentC addChildViewController:contro];
            [contro didMoveToParentViewController:parentC];
            
        }
        
        
        // 创建segmentButton 和 line
        
        for (int i = 0; i < self.controllers.count; i++) {
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(i * (SCREEN_WIDTH / self.controllers.count), 0, SCREEN_WIDTH / self.controllers.count, 48*KWidth_ScaleW);
            button.tag = i;
            [button setTitle:self.buttonName[i] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [button setTitleColor:UIColorFromRGBA(68, 195, 34, 1) forState:UIControlStateSelected];
            [button addTarget:self action:@selector(Click:) forControlEvents:UIControlEventTouchUpInside];
            button.titleLabel.font = [UIFont systemFontOfSize:18*KWidth_ScaleW];
            if (i == 0) {
                
                button.selected = YES;
                self.selectButton = button;
                button.titleLabel.font = [UIFont systemFontOfSize:20*KWidth_ScaleW];
                
            }
            else {
                
                button.selected = NO;
                
            }
            
            [self.segmentView addSubview:button];
        }
        
        // 添加下划线
        self.underLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 46.8*KWidth_ScaleW, SCREEN_WIDTH / self.controllers.count, 2)];
        
        self.underLine.backgroundColor = UIColorFromRGBA(202, 44, 51, 1);
        self.underLine.tag = 70;
      //  [self.segmentView addSubview:self.underLine];
        
       // self.downLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 48.5*KWidth_ScaleW, SCREEN_WIDTH, 0.5*KWidth_ScaleW)];
        //self.downLine.backgroundColor = [UIColor grayColor];
       // [self.segmentView addSubview:self.downLine];
        //添加长线下划线
        
        self.lineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 47.5*KWidth_ScaleW, SCREEN_WIDTH, 0.5)];
        [self.lineImageView setImage:[UIImage imageNamed:@"239色块"]];
        [self.segmentView addSubview:self.lineImageView];
    }
    
    return self;
}

- (void)setClickIndex:(NSInteger)clickIndex{

    _clickIndex = clickIndex;
    UIButton *btn = [self viewWithTag:clickIndex-1];
    if (clickIndex!=1) {
         [self Click:btn];
    }
}
- (void)Click:(UIButton *)sender {
    
    self.selectButton.titleLabel.font = [UIFont systemFontOfSize:18*KWidth_ScaleW];
    self.selectButton.selected = NO;
    self.selectButton = sender;
    self.selectButton.selected = YES;
    self.selectButton.titleLabel.font = [UIFont systemFontOfSize:20*KWidth_ScaleW];
    [UIView animateWithDuration:0.2 animations:^{
        
        CGPoint frame = self.underLine.center;
        frame.x = SCREEN_WIDTH / (self.controllers.count * 2) + (SCREEN_WIDTH / self.controllers.count) * (sender.tag);
        self.underLine.center = frame;
        
    }];
    
    [self.segmentScrollV setContentOffset:CGPointMake((sender.tag) * SCREEN_WIDTH, 0) animated:YES];
    
}

#pragma mark  UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    [UIView animateWithDuration:0.2 animations:^{
        
        CGPoint frame = self.underLine.center;
        frame.x = SCREEN_WIDTH / (self.controllers.count * 2) + (SCREEN_WIDTH / self.controllers.count) * (self.segmentScrollV.contentOffset.x/SCREEN_WIDTH);
        self.underLine.center = frame;
        
    }];
    
    UIButton *button = (UIButton *)[self.segmentView viewWithTag:self.segmentScrollV.contentOffset.x / SCREEN_WIDTH];
    self.selectButton.titleLabel.font = [UIFont systemFontOfSize:18*KWidth_ScaleW];
    self.selectButton.selected = NO;
    self.selectButton = button;
    self.selectButton.selected = YES;
    self.selectButton.titleLabel.font = [UIFont systemFontOfSize:20*KWidth_ScaleW];
  
}



@end
