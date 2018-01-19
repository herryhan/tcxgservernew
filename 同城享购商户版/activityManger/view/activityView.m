//
//  activityView.m
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/12/7.
//  Copyright © 2017年 韩先炜. All rights reserved.
//

#import "activityView.h"

@implementation activityView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *arrayObjectViews = [[NSBundle mainBundle] loadNibNamed:@"activityView" owner:self options:nil];
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
    self.discontView.hidden = YES;
    self.commitBtn.backgroundColor = UIColorFromRGBA(68, 195, 34, 1);
    self.commitBtn.layer.cornerRadius = 5;
    self.subText.delegate = self;
    self.fullText.delegate = self;
}

- (IBAction)fullAndSubPress:(UIButton *)sender {
    [self resign];
    _fullAndSub(YES);
}
- (IBAction)beginBtnPress:(UIButton *)sender {
    [self resign];
    if (sender.tag == 9001) {
        
        _timeSelected(YES);
    }else if (sender.tag == 9002){
        _timeSelected(NO);
    }
    
}
- (IBAction)discountPress:(UIButton *)sender {
    [self resign];
    _discountSelected(YES);
}

- (IBAction)typeSelectedPress:(UIButton *)sender {
    [self resign];
    _selectedGoodsType(YES);
}
- (IBAction)submitPress:(UIButton *)sender {
    _submit(YES);
}

- (void)resign{
    [self.fullText resignFirstResponder];
    [self.subText resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.fullText resignFirstResponder];
    [self.subText resignFirstResponder];
    return YES;
}
@end
