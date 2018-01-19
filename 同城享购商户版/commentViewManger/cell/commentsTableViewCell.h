//
//  commentsTableViewCell.h
//  同城享购商户版
//
//  Created by 韩先炜 on 2017/12/9.
//  Copyright © 2017年 韩先炜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "commentsModel.h"

@interface commentsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *commentTime;
@property (weak, nonatomic) IBOutlet UILabel *commentScore;
@property (weak, nonatomic) IBOutlet UILabel *commentContent;
@property (weak, nonatomic) IBOutlet UILabel *resLabel;
@property (weak, nonatomic) IBOutlet UIButton *replyBtn;

@property (nonatomic,strong) commentsModel *model;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;
@property (weak, nonatomic) IBOutlet UILabel *resTitleLabel;

@property (nonatomic,strong) void(^res)(BOOL isRes);

@end
