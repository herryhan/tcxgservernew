//
//  mangerView.h
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/11/23.
//  Copyright © 2017年 韩先炜. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mangerView : UIView

@property (weak, nonatomic) IBOutlet UIButton *goodsMangerBtn;
@property (weak, nonatomic) IBOutlet UIButton *cateBtn;
@property (weak, nonatomic) IBOutlet UIButton *addGoodsBtn;
@property (weak, nonatomic) IBOutlet UIButton *addCartBtn;

@property (weak, nonatomic) IBOutlet UIButton *waitOrderBtn;
@property (weak, nonatomic) IBOutlet UIButton *sendBtn;
@property (weak, nonatomic) IBOutlet UIButton *backMoneyBtn;
@property (weak, nonatomic) IBOutlet UIButton *allOrderBtn;

@property (weak, nonatomic) IBOutlet UIButton *unBeginBtn;
@property (weak, nonatomic) IBOutlet UIButton *ingBtn;
@property (weak, nonatomic) IBOutlet UIButton *finishBtn;
@property (weak, nonatomic) IBOutlet UIButton *addActivityBtn;

@property (weak, nonatomic) IBOutlet UIButton *unFeedBackBtn;
@property (weak, nonatomic) IBOutlet UIButton *badJudgeBtn;
@property (weak, nonatomic) IBOutlet UIButton *allCommenBtn;

@property (weak, nonatomic) IBOutlet UIButton *shopQRBtn;
@property (weak, nonatomic) IBOutlet UIButton *openTimeBtn;
@property (weak, nonatomic) IBOutlet UIButton *shopSetBtn;
@property (weak, nonatomic) IBOutlet UIButton *changeBtn;

@property (weak, nonatomic) IBOutlet UIButton *advBtn;

@property (weak, nonatomic) IBOutlet UIButton *contractBtn;
@property (weak, nonatomic) IBOutlet UIButton *cashHistoryBtn;
@property (weak, nonatomic) IBOutlet UIButton *changePwdBtn;


@property (weak, nonatomic) IBOutlet UIView *borderView;
@property (weak, nonatomic) IBOutlet UIView *borderView2;
@property (weak, nonatomic) IBOutlet UIView *borderView3;
@property (weak, nonatomic) IBOutlet UIView *borderView4;
@property (weak, nonatomic) IBOutlet UIView *borderView5;


@property (weak, nonatomic) IBOutlet UIView *sepLineView1;
@property (weak, nonatomic) IBOutlet UIView *sepLineView2;
@property (weak, nonatomic) IBOutlet UIView *sepLineView3;
@property (weak, nonatomic) IBOutlet UIView *sepLineView4;
@property (weak, nonatomic) IBOutlet UIView *sepLineView5;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *firstConstrait;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *secondContrait;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *thirdContrait;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *forthContrait;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fifthContrait;
@property (weak, nonatomic) IBOutlet UIButton *sellersInfoLabel;

@property (nonatomic,strong) NSString *sellersInfoString;

@property (nonatomic,strong) void(^btnClick)(NSInteger tag);

@property (weak, nonatomic) IBOutlet UIButton *shopCopyBtn;

@property (weak, nonatomic) IBOutlet UIButton *shopBtn;

@end
