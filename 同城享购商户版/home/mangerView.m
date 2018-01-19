//
//  mangerView.m
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/11/23.
//  Copyright © 2017年 韩先炜. All rights reserved.
//

#import "mangerView.h"

@implementation mangerView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *arrayObjectViews = [[NSBundle mainBundle] loadNibNamed:@"mangerView" owner:self options:nil];
        if (arrayObjectViews.count <1) {
            return nil;
        }else{
            
            for (id obj in arrayObjectViews) {
                self = obj;
                self.frame = frame;
                [self uiconfig];
            }
        }
    }
    return self;
}
- (void)uiconfig{
    //row one
    [self initButton:self.goodsMangerBtn];
    [self initButton:self.cateBtn];
    [self initButton:self.addGoodsBtn];
    [self initButton:self.addCartBtn];
    [self initButton:self.shopCopyBtn];
    //row two
    [self initButton:self.waitOrderBtn];
    [self initButton:self.sendBtn];
    [self initButton:self.backMoneyBtn];
    [self initButton:self.allOrderBtn];
    //row three
    [self initButton:self.unBeginBtn];
    [self initButton:self.ingBtn];
    [self initButton:self.finishBtn];
    [self initButton:self.addActivityBtn];
    //row four
    [self initButton:self.unFeedBackBtn];
    [self initButton:self.badJudgeBtn];
    [self initButton:self.allCommenBtn];
    //row five
    [self initButton:self.shopQRBtn];
    [self initButton:self.openTimeBtn];
    [self initButton:self.shopSetBtn];
    [self initButton:self.changeBtn];
    [self initButton:self.contractBtn];
    [self initButton:self.cashHistoryBtn];
    [self initButton:self.changePwdBtn];
    [self initButton:self.advBtn];
    [self initButton:self.shopBtn];
    
    [self.sellersInfoLabel setTitleColor:UIColorFromRGBA(68, 195, 34, 1) forState:UIControlStateNormal];
    
    self.borderView.backgroundColor = UIColorFromRGBA(68, 195, 34, 1);
    self.borderView2.backgroundColor = UIColorFromRGBA(68, 195, 34, 1);
    self.borderView3.backgroundColor = UIColorFromRGBA(68, 195, 34, 1);
    self.borderView4.backgroundColor = UIColorFromRGBA(68, 195, 34, 1);
    self.borderView5.backgroundColor = UIColorFromRGBA(68, 195, 34, 1);
    
    self.sepLineView1.backgroundColor = UIColorFromRGBA(239, 239, 239, 1);
    self.sepLineView2.backgroundColor = UIColorFromRGBA(239, 239, 239, 1);
    self.sepLineView3.backgroundColor = UIColorFromRGBA(239, 239, 239, 1);
    self.sepLineView4.backgroundColor = UIColorFromRGBA(239, 239, 239, 1);
    self.sepLineView5.backgroundColor = UIColorFromRGBA(239, 239, 239, 1);

    self.firstConstrait.constant = 55+(SCREEN_WIDTH-30)/4 *2;
    self.secondContrait.constant = 55+(SCREEN_WIDTH-30)/4;
    self.thirdContrait.constant = 55+(SCREEN_WIDTH-30)/4;
    self.forthContrait.constant = 55+(SCREEN_WIDTH-30)/4;
    self.fifthContrait.constant = 55+(SCREEN_WIDTH-30)/4 * 2;
    
}

- (void)setSellersInfoString:(NSString *)sellersInfoString{
    
    _sellersInfoString = sellersInfoString;
     [self.sellersInfoLabel setTitle:self.sellersInfoString forState:UIControlStateNormal];
    
}
-(void)initButton:(UIButton*)btn{
    float  spacing = 8;//图片和文字的上下间距
    if (IPHONE5) {
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
    }
    CGSize imageSize = btn.imageView.frame.size;
    CGSize titleSize = btn.titleLabel.frame.size;
    CGSize textSize = [btn.titleLabel.text sizeWithAttributes:@{NSFontAttributeName : btn.titleLabel.font}];
    CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
    if (titleSize.width + 0.5 < frameSize.width) {
        titleSize.width = frameSize.width;
    }
    CGFloat totalHeight = (imageSize.height + titleSize.height + spacing);
    btn.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0, 0.0, - titleSize.width);
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, - (totalHeight - titleSize.height), 0);
  
    
}
#pragma button action

- (IBAction)dialPhone:(UIButton *)sender {
   // if (sender.tag == 1001) {
    _btnClick(sender.tag);
    
  //  }else{
        
  //  }
}

@end
