//
//  shopSettingsView.m
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/12/2.
//  Copyright © 2017年 韩先炜. All rights reserved.
//

#import "shopSettingsView.h"
#import "KeyboardToolBar.h"
@implementation shopSettingsView

-(instancetype) initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *arrayObjectViews = [[NSBundle mainBundle] loadNibNamed:@"shopSettingsView" owner:self options:nil];
        if (arrayObjectViews.count <1) {
            return nil;
        }else{
            
            for (id obj in arrayObjectViews) {
                self = obj;
                self.frame = frame;
              
            }
        }
    }
    return self;
}
- (void)uiconfig{
 

}
- (IBAction)selectedImageBtnPress:(UIButton *)sender {
    
    _uploadImage(sender.tag);
    
}

- (void)setDataDic:(NSDictionary *)dataDic{
    
    [self.logoImage sd_setImageWithURL:[NSURL URLWithString:dataDic[@"logo"]] placeholderImage:[UIImage imageNamed:@"239色块"]];
    self.shopNameText.text = dataDic[@"name"];
    self.connectPhoneText.text =dataDic[@"tel"];
    self.qqText.text =dataDic[@"qq"];
    self.addressText.text = dataDic[@"address"];
    self.getAddressText.text = dataDic[@"address2"];
    self.mangerPhoneText.text = dataDic[@"contactTel"];
    self.mangerNameText.text = dataDic[@"contactName"];
    self.bankNameText.text = dataDic[@"bankName"]; 
    self.bankCardNum.text = dataDic[@"bankNo"];
    self.creditCardUserNameText.text = dataDic[@"bankRealname"];

    [self.yyzzImage sd_setImageWithURL:[NSURL URLWithString:dataDic[@"pic1"]] placeholderImage:[UIImage imageNamed:@"239色块"]];
    [self.spltImage sd_setImageWithURL:[NSURL URLWithString:dataDic[@"pic2"]] placeholderImage:[UIImage imageNamed:@"239色块"]];
    [self.identyImage sd_setImageWithURL:[NSURL URLWithString:dataDic[@"pic3"]] placeholderImage:[UIImage imageNamed:@"239色块"]];
    [self.holdIdentyImage sd_setImageWithURL:[NSURL URLWithString:dataDic[@"pic4"]] placeholderImage:[UIImage imageNamed:@"239色块"]];
    [self.bankCardImage sd_setImageWithURL:[NSURL URLWithString:dataDic[@"pic5"]] placeholderImage:[UIImage imageNamed:@"239色块"]];
    [self.reBankCardImage sd_setImageWithURL:[NSURL URLWithString:dataDic[@"pic6"]] placeholderImage:[UIImage imageNamed:@"239色块"]];
    [self.specialIamge sd_setImageWithURL:[NSURL URLWithString:dataDic[@"pic7"]] placeholderImage:[UIImage imageNamed:@"239色块"]];
    [self.other1Image sd_setImageWithURL:[NSURL URLWithString:dataDic[@"pic8"]] placeholderImage:[UIImage imageNamed:@"239色块"]];
    [self.other2Image sd_setImageWithURL:[NSURL URLWithString:dataDic[@"pic9"]] placeholderImage:[UIImage imageNamed:@"239色块"]];
    
}

@end
