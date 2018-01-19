//
//  shopSettingsView.h
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/12/2.
//  Copyright © 2017年 韩先炜. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface shopSettingsView : UIView

@property (weak, nonatomic) IBOutlet UITextField *shopNameText;
@property (weak, nonatomic) IBOutlet UITextField *connectPhoneText;
@property (weak, nonatomic) IBOutlet UITextField *qqText;
@property (weak, nonatomic) IBOutlet UITextField *addressText;
@property (weak, nonatomic) IBOutlet UITextField *getAddressText;
@property (weak, nonatomic) IBOutlet UITextField *mangerPhoneText;
@property (weak, nonatomic) IBOutlet UITextField *mangerNameText;
@property (weak, nonatomic) IBOutlet UITextField *bankNameText;
@property (weak, nonatomic) IBOutlet UITextField *bankCardNum;
@property (weak, nonatomic) IBOutlet UITextField *creditCardUserNameText;
@property (weak, nonatomic) IBOutlet UIImageView *logoImage;
@property (weak, nonatomic) IBOutlet UIImageView *yyzzImage;
@property (weak, nonatomic) IBOutlet UIImageView *spltImage;
@property (weak, nonatomic) IBOutlet UIImageView *identyImage;

@property (weak, nonatomic) IBOutlet UIImageView *holdIdentyImage;
@property (weak, nonatomic) IBOutlet UIImageView *bankCardImage;
@property (weak, nonatomic) IBOutlet UIImageView *reBankCardImage;
@property (weak, nonatomic) IBOutlet UIImageView *specialIamge;
@property (weak, nonatomic) IBOutlet UIImageView *other1Image;
@property (weak, nonatomic) IBOutlet UIImageView *other2Image;

@property (nonatomic ,strong) NSDictionary *dataDic;

@property (nonatomic ,strong) void(^uploadImage)(NSInteger tag);

@end
