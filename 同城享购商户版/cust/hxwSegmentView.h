//
//  hxwSegmentView.h
//  一筹百应
//
//  Created by 庄园 on 17/10/12.
//  Copyright © 2017年 择善基金. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface hxwSegmentView : UIView <UIScrollViewDelegate>

- (instancetype)initWithFrame:(CGRect)frame buttonName:(NSArray*)buttonName contrllers:(NSArray*)contrllers parentController:(UIViewController*)parentC;


@property (nonatomic, strong) UIScrollView *segmentScrollV;

@property (assign,nonatomic) NSInteger clickIndex;

@end
