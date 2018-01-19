//
//  activityView.h
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/12/7.
//  Copyright © 2017年 韩先炜. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface activityView : UIView <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *activityTypeBtn;
@property (weak, nonatomic) IBOutlet UIButton *beginTimeBtn;
@property (weak, nonatomic) IBOutlet UIButton *endTimeBtn;
@property (weak, nonatomic) IBOutlet UIButton *goodTypeBtn;
@property (weak, nonatomic) IBOutlet UIView *fullWithsubView;
@property (weak, nonatomic) IBOutlet UIView *discontView;
@property (weak, nonatomic) IBOutlet UITextField *fullText;
@property (weak, nonatomic) IBOutlet UITextField *subText;
@property (weak, nonatomic) IBOutlet UIButton *discontBtn;
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;
@property (weak, nonatomic) IBOutlet UIButton *typeBtn;
@property (weak, nonatomic) IBOutlet UIButton *discountBtn;

@property (nonatomic,strong) void(^fullAndSub)(BOOL isShow);

@property (nonatomic,strong) void(^timeSelected)(BOOL isBeginTime);

@property (nonatomic,strong) void(^selectedGoodsType)(BOOL isSelected);

@property (nonatomic,strong) void(^discountSelected)(BOOL isSelected);

@property (nonatomic,strong) void(^submit)(BOOL isTouchSubmit);

@end
